import pandas as pd
import os
from django.conf import settings
from .models import Tracker


def load_sleep_and_meditation_data():
    """Loads sleep data from CSV and combines it with meditation logs from the database."""

    # 1️⃣ Load Sleep Data from CSV
    sleep_file_path = os.path.join(settings.BASE_DIR, "data", "sleep.csv")

    try:
        sleep_df = pd.read_csv(sleep_file_path)
    except FileNotFoundError:
        print("⚠️ Sleep CSV file not found!")
        return None

    # Ensure column names are correct (modify if needed)
    sleep_df.columns = ["Date", "Sleep Score", "Resting HR", "Body Battery", "Pulse Ox",
                        "Respiration", "HRV", "Quality", "Duration", "Sleep Need",
                        "Bedtime", "Wake Time"]

    # Convert date to proper format
    sleep_df["Date"] = pd.to_datetime(sleep_df["Date"]).dt.date  # Keep only date part

    # 2️⃣ Load Meditation Logs from Django Database
    meditation_logs = Tracker.objects.filter(activity_type="meditation").values(
        "user__username", "timestamp", "duration"
    )

    meditation_df = pd.DataFrame(list(meditation_logs))

    if meditation_df.empty:
        print("⚠️ No meditation data found in the database!")
        return None

    # Convert timestamp to Date format
    meditation_df["timestamp"] = pd.to_datetime(meditation_df["timestamp"]).dt.date
    meditation_df.rename(columns={"timestamp": "Date", "duration": "Meditation Duration"}, inplace=True)

    # 3️⃣ Merge Sleep & Meditation Data on Date
    merged_df = pd.merge(sleep_df, meditation_df, on="Date", how="left")

    # Fill NaN values for days where no meditation was logged
    merged_df["Meditation Duration"].fillna(0, inplace=True)

    return merged_df
