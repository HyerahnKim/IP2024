# APP level urls

from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path
from . import views # Import views as a module instead of individual imports
from rest_framework.authtoken.views import obtain_auth_token



urlpatterns = [
    path('', views.index, name='index'),  # Dashboard page
    path('login/', views.login, name='login'),  # Login page
    path('api/meditations/', views.meditations_list, name='meditations_list'),  # Reference views.meditations_list
    path('api/quote/', views.daily_quote, name='daily_quote'),  # Reference views.daily_quote
    path('api/meditation/log/', views.log_meditation, name='log_meditation'),  # Reference views.log_meditation
    path('meditation/history/', views.meditation_history, name='meditation_history'),
    path('meditation/log/', views.log_meditation_page, name='log_meditation_page'),
    path('api/meditation/logs/<str:user>/', views.get_meditation_logs, name='get_meditation_logs'),  # Reference views.get_meditation_logs
    path('api-token-auth/', obtain_auth_token, name='api_token_auth'),  # Token authentication endpoint
    path('api/meditation/log/<int:log_id>/', views.manage_meditation_log, name='manage_meditation_log'),
    path('api/meditation/stats/<str:user>/', views.meditation_stats, name='meditation_stats'),
    path("spotify/login/", views.spotify_login, name="spotify_login"),
    path("callback/", views.spotify_callback, name="spotify_callback"),
    path('view-dataset/', views.dataset_view, name='view_dataset'),
]

urlpatterns += [
    path('password_reset/', auth_views.PasswordResetView.as_view(), name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(), name='password_reset_complete'),
]