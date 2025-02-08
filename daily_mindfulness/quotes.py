from core.models import Quote  # Adjust 'core' to your app name
from django.db import transaction

# List of quotes (now using 'source' instead of 'author')
quotes = [
    {"text": "Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.", "source": "Buddha"},
    {"text": "Peace comes from within. Do not seek it without.", "source": "Buddha"},
    {"text": "When you realize how perfect everything is, you will tilt your head back and laugh at the sky.", "source": "Korean Zen Saying"},
    {"text": "If you want to know the past, look at your present. If you want to know the future, look at your present.", "source": "Korean Proverb"},
    {"text": "A wise man, recognizing that the world is but an illusion, does not act as if it is real, so he escapes the suffering.", "source": "Buddha"},
    {"text": "It is easy to see the faults of others, but difficult to see one’s own faults.", "source": "Buddha"},
    {"text": "Let go of what you are and become what you might be.", "source": "Zen Wisdom"},
    {"text": "The mind is everything. What you think you become.", "source": "Buddha"},
    {"text": "Thousands of candles can be lighted from a single candle, and the life of the candle will not be shortened. Happiness never decreases by being shared.", "source": "Buddha"},
    {"text": "The trouble is, you think you have time.", "source": "Zen Saying"},
    {"text": "At the cessation of defilement, the cycle of life and death too ends.\n\nWhen arising and ceasing vanish, A calm radiance is revealed, Which unfolds and functions perfectly in unlimited responsiveness.", "source": "Bojo Jinul"},
    {"text": "Pear blossoms in 10,000 petals, \nSwirl into the silent clarity of an empty house.\nThe sound of an oxherd's flute floats down the mountain, \nYet, cannot see the oxherd, cannot see the ox.", "source": "Cheongheo Hyujeong"},
    {"text": "Lotuses never bloom in the lofty hills or high terrain. Instead, this flower unfurls its petals in lowly swampland.", "source": "The Vimalakirti Sutra"}
]

# Bulk insert quotes into the database
with transaction.atomic():  # Ensures the process is atomic
    Quote.objects.bulk_create([Quote(text=quote["text"], source=quote["source"]) for quote in quotes])

print("Korean Buddhist quotes have been successfully added!")
