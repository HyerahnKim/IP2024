import pandas as pd
from .models import Tracker
from datetime import datetime
from django.contrib.auth.models import User
import numpy as np
from sklearn.linear_model import LinearRegression




def load_sleep_data(file_path="data/sleep.csv"):
    """
    Load sleep data from a CSV file and preprocess it.
    """
    sleep_df = pd.read_csv(file_path)

    # Normalize column names (strip spaces, lowercase)
    sleep_df.columns = sleep_df.columns.str.strip().str.lower()

    # Ensure the date column is properly formatted
    if "date" not in sleep_df.columns:
        raise KeyError(f"Expected 'date' column not found. Found: {sleep_df.columns.tolist()}")

    # Get the current year
    current_year = datetime.now().year

    # Convert 'date' column to datetime, setting the current year
    sleep_df["date"] = pd.to_datetime(sleep_df["date"] + f" {current_year}", format="%d %b %Y", errors="coerce").dt.date

    return sleep_df

def load_meditation_data():
    """
    Load meditation data from the Django database.
    """
    meditation_logs = Tracker.objects.filter(activity_type="meditation").values("timestamp", "duration")

    # Convert to DataFrame
    meditation_df = pd.DataFrame.from_records(meditation_logs)

    # Convert timestamp to just the date
    meditation_df["date"] = pd.to_datetime(meditation_df["timestamp"]).dt.date

    return meditation_df

def merge_sleep_and_meditation(sleep_df, meditation_df):
    """
    Merge sleep and meditation data based on the date.
    """
    combined_df = pd.merge(sleep_df, meditation_df, on="date", how="outer").fillna(0)
    return combined_df

def analyze_sleep_meditation():
    """
    Uses AI to analyze the relationship between sleep quality and meditation habits.
    """

    # Load merged data
    sleep_df = load_sleep_data("data/sleep.csv")
    meditation_df = load_meditation_data()
    df = merge_sleep_and_meditation(sleep_df, meditation_df)

    # Ensure numerical values for AI analysis
    df["meditation_duration"] = df["duration_y"].fillna(0).astype(int)
    df["sleep_score"] = df["score"].fillna(df["score"].mean()).astype(int)  # Replace NaN with mean

    # Features (X) and Target (y)
    X = df[["meditation_duration"]]
    y = df["sleep_score"]

    # Train a simple linear regression model
    model = LinearRegression()
    model.fit(X, y)

    # Predict sleep score based on meditation duration
    df["predicted_sleep_score"] = model.predict(X)

    return df