from rest_framework import serializers
from .models import Meditation, Quote, Tracker

class MeditationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meditation
        fields = '__all__'

class QuoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quote
        fields = '__all__'

class TrackerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tracker
        fields = '__all__'
        read_only_fields = ['user']  # Prevent users from manually setting the user field

    def create(self, validated_data):
        # Safely get the authenticated user from the request context
        request = self.context.get('request')
        if not request:
            raise serializers.ValidationError("Request context is missing.")
        validated_data['user'] = request.user
        return super().create(validated_data)
