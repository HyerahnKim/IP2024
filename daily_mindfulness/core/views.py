import logging # from django.utils.log import logger
import random
import urllib.parse
import requests
import pandas as pd

from django.db.models import Sum, Q
from django.conf import settings
from django.shortcuts import redirect
from django.http import JsonResponse

from django.http import HttpResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from .models import Meditation, Quote, Tracker
from .serializers import MeditationSerializer, QuoteSerializer, TrackerSerializer

from .utils import load_sleep_data, load_meditation_data, merge_sleep_and_meditation, analyze_sleep_meditation
from django.shortcuts import render, redirect

def index(request):
    return render(request, "index.html")  # Serve the dashboard page

def login(request):
    return render(request, "login.html")  # Serve the login page

def meditation_history(request):
    return render(request, 'meditation_history.html')

def log_meditation_page(request):
    return render(request, 'log_meditation.html')

def dataset_view(request):
    # Load individual datasets
    sleep_df = load_sleep_data()
    meditation_df = load_meditation_data()

    # Merge the datasets
    df = merge_sleep_and_meditation(sleep_df, meditation_df)

    # Convert DataFrame to HTML
    data_html = df.to_html()

    return render(request, 'dataset.html', {'data_html': data_html})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def combined_data_api(request):
    sleep_df = load_sleep_data()
    meditation_df = load_meditation_data()
    # Merge the two datasets
    combined_df = merge_sleep_and_meditation(sleep_df, meditation_df)
    return JsonResponse(combined_df.to_dict(orient="records"), safe=False)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def ai_analysis_api(request):
    """
    API endpoint to return AI-based insights on meditation and sleep.
    """
    df = analyze_sleep_meditation()
    return JsonResponse(df.to_dict(orient="records"), safe=False)



# Initialize the logger
logger = logging.getLogger(__name__)


class MeditationViewSet(viewsets.ModelViewSet):
    queryset = Meditation.objects.all()
    serializer_class = MeditationSerializer

class QuoteViewSet(viewsets.ModelViewSet):
    queryset = Quote.objects.all()
    serializer_class = QuoteSerializer

class TrackerViewSet(viewsets.ModelViewSet):
    queryset = Tracker.objects.all()
    serializer_class = TrackerSerializer

@api_view(['GET'])
def meditations_list(request):
    meditations = Meditation.objects.all()  # Fetch all meditations from the database
    serializer = MeditationSerializer(meditations, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([AllowAny])  # Allow access to everyone
def daily_quote(request):
    logger.debug("Permissions for daily_quote: AllowAny")
    # Fetch all quotes from the database
    quotes = Quote.objects.all()
    if quotes.exists():
        # Select a random quote
        random_quote = random.choice(quotes)
        serializer = QuoteSerializer(random_quote)
        return Response(serializer.data)
    else:
        return Response({"message": "No quotes available."}, status=404)


@api_view(['POST', 'GET'])
@permission_classes([IsAuthenticated])
def log_meditation(request):
    logger = logging.getLogger(__name__)  # Ensure logger is initialized
    try:
        logger.info(f"Authorization Header: {request.META.get('HTTP_AUTHORIZATION')}")
        logger.info(f"User: {request.user}")  # Log the authenticated user

        if request.method == 'POST':
            logger.info(f"Request data: {request.data}")  # Log incoming data

            # Process the POST request to log a meditation session
            data = request.data.copy()

            # ✅ Ensure timestamp is properly handled
            if 'timestamp' in data and data['timestamp']:
                try:
                    data['timestamp'] = pd.to_datetime(data['timestamp'])
                except ValueError:
                    return Response({"error": "Invalid timestamp format"}, status=400)

            serializer = TrackerSerializer(data=data, context={'request': request})  # Pass the request context

            if serializer.is_valid():
                instance = serializer.save()
                logger.info("Meditation log saved successfully.")
                return Response(serializer.data, status=201)
            else:
                logger.error(f"Validation errors: {serializer.errors}")
                return Response(serializer.errors, status=400)

        elif request.method == 'GET':
            # Process the GET request to retrieve logged meditation sessions
            logs = Tracker.objects.filter(user=request.user, activity_type="meditation").order_by('-timestamp')
            serializer = TrackerSerializer(logs, many=True)
            return Response(serializer.data, status=200)

    except Exception as e:
        logger.error(f"An unexpected error occurred: {e}")  # Log unexpected errors
        return Response({"error": "An unexpected error occurred."}, status=500)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_meditation_logs(request, user):
    try:
        # Check if the user making the request is the same as the user in the URL or an admin
        if request.user.username != user and not request.user.is_staff:
            return Response({"detail": "You are not authorized to view these logs."}, status=403)

        # Fetch meditation logs for the specified user
        logs = Tracker.objects.filter(user__username=user, activity_type="meditation").order_by('-timestamp')

        # Check if logs exist
        if not logs.exists():
            return Response({"detail": "No meditation logs found for this user."}, status=404)

        # Serialize the logs
        serializer = TrackerSerializer(logs, many=True)
        return Response(serializer.data, status=200)

    except Exception as e:
        # Log unexpected errors and return a generic error response
        logger = logging.getLogger(__name__)
        logger.error(f"Error fetching meditation logs for user {user}: {str(e)}")
        return Response({"error": "An unexpected error occurred."}, status=500)


@api_view(['PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def manage_meditation_log(request, log_id):
    try:
        log = Tracker.objects.get(id=log_id, user=request.user)
    except Tracker.DoesNotExist:
        return Response({"detail": "Log not found."}, status=404)

    if request.method == 'PUT':
        serializer = TrackerSerializer(log, data=request.data, partial=True, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=200)
        return Response(serializer.errors, status=400)

    elif request.method == 'DELETE':
        log.delete()
        return Response({"detail": "Log deleted successfully."}, status=204)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def meditation_stats(request, user):
    try:
        # Check if the requesting user matches the user in the URL or is an admin
        if request.user.username != user and not request.user.is_staff:
            return Response({"detail": "You are not authorized to view these stats."}, status=403)

        # Fetch meditation logs for the user
        logs = Tracker.objects.filter(user__username=user, activity_type="meditation")

        # Calculate stats
        total_duration = logs.aggregate(total_duration=Sum('duration'))['total_duration'] or 0
        total_sessions = logs.count()
        avg_duration = total_duration / total_sessions if total_sessions > 0 else 0

        return Response({
            "total_duration": total_duration,
            "total_sessions": total_sessions,
            "avg_duration": round(avg_duration, 2)
        }, status=200)

    except Exception as e:
        return Response({"error": str(e)}, status=500)

# spotify login
def spotify_login(request):
    # Spotify authorization URL
    auth_url = "https://accounts.spotify.com/authorize"
    scopes = "user-read-playback-state user-read-currently-playing"

    params = {
        "response_type": "code",
        "client_id": settings.SPOTIFY_CLIENT_ID,
        "scope": scopes,
        "redirect_uri": settings.SPOTIFY_REDIRECT_URI,
    }

    # Build the full authorization URL
    url = f"{auth_url}?{urllib.parse.urlencode(params)}"
    return redirect(url)

#  Spotify callback
def spotify_callback(request):
    # Get the authorization code from the query parameters
    code = request.GET.get("code")
    error = request.GET.get("error")

    if error:
        return JsonResponse({"error": error})

    # Exchange the authorization code for an access token
    token_url = "https://accounts.spotify.com/api/token"
    response = requests.post(
        token_url,
        data={
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": settings.SPOTIFY_REDIRECT_URI,
            "client_id": settings.SPOTIFY_CLIENT_ID,
            "client_secret": settings.SPOTIFY_CLIENT_SECRET,
        },
    )

    # Check if the token request was successful
    if response.status_code == 200:
        token_data = response.json()
        access_token = token_data["access_token"]
        refresh_token = token_data["refresh_token"]
        expires_in = token_data["expires_in"]

        # Return the tokens as a response or save them for later use
        return JsonResponse({
            "access_token": access_token,
            "refresh_token": refresh_token,
            "expires_in": expires_in,
        })
    else:
        return JsonResponse({"error": "Failed to fetch access token"})