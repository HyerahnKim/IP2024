from django.db import models
from django.contrib.auth.models import User

class Meditation(models.Model):
    title = models.CharField(max_length=100)
    duration = models.IntegerField()  # Duration in minutes
    theme = models.CharField(max_length=50)
    url = models.URLField()

class Quote(models.Model):
    text = models.TextField()  # The quote text
    source = models.CharField(max_length=255, blank=True, null=True)  # Optional source of the quote

    def __str__(self):
        return self.text[:50]  # Display the first 50 characters for admin


class Tracker(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Link to Django's User model
    activity_type = models.CharField(max_length=50)
    duration = models.IntegerField()
    timestamp = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.user.username} - {self.activity_type} on {self.timestamp}"