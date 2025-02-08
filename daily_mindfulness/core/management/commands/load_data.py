import pandas as pd
from django.core.management.base import BaseCommand
from ...utils import load_sleep_data, load_meditation_data, merge_sleep_and_meditation

class Command(BaseCommand):
    help = "Load sleep and meditation data and merge them"

    def handle(self, *args, **kwargs):
        # Load sleep and meditation data
        sleep_df = load_sleep_data()
        meditation_df = load_meditation_data()

        # Merge data
        combined_df = merge_sleep_and_meditation(sleep_df, meditation_df)

        if combined_df is not None:
            self.stdout.write(self.style.SUCCESS("Successfully loaded and merged datasets!"))
            # ✅ Print the **full** DataFrame (not just 5 rows)
            pd.set_option("display.max_rows", None)  # Show all rows
            print(combined_df)  # Print preview in console
        else:
            self.stdout.write(self.style.ERROR("Failed to load or merge data."))