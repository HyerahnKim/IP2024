document.getElementById('fetchQuote').addEventListener('click', async () => {
    const token = localStorage.getItem('token');  // Assume token is stored in localStorage
    if (!token) {
        alert('You are not logged in.');
        return;
    }

    try {
        const response = await fetch('http://127.0.0.1:8000/api/quote/', {
            headers: {
                'Authorization': `Token ${token}`,
                'Content-Type': 'application/json',
            },
        });

        if (response.ok) {
            const data = await response.json();
            document.getElementById('quote').textContent = data.quote || 'No quote available.';
        } else {
            document.getElementById('quote').textContent = 'Failed to fetch quote.';
        }
    } catch (error) {
        document.getElementById('quote').textContent = 'An error occurred.';
    }
});

document.addEventListener('DOMContentLoaded', async () => {
    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = 'login.html';
        return;
    }

    try {
        const response = await fetch('http://127.0.0.1:8000/api/quote/', {
            headers: {
                'Authorization': `Token ${token}`,
            },
        });

        if (response.ok) {
            const data = await response.json();
            document.getElementById('quote').textContent = data.quote || 'No quote available.';
        } else {
            document.getElementById('quote').textContent = 'Failed to fetch the quote.';
        }
    } catch (error) {
        document.getElementById('quote').textContent = 'An error occurred while fetching the quote.';
    }
});

document.getElementById('logout').addEventListener('click', () => {
    localStorage.removeItem('token');
    window.location.href = 'login.html';
});

document.getElementById('logMeditationForm').addEventListener('submit', async function (event) {
    event.preventDefault();

    const duration = document.getElementById('duration').value;
    const dateInput = document.getElementById('date').value;

    if (!duration || !dateInput) {
        alert('Please select a duration and date.');
        return;
    }

    // ✅ Convert selected date to proper timestamp format (YYYY-MM-DDTHH:mm:ssZ)
    const selectedDate = new Date(dateInput);
    const formattedTimestamp = selectedDate.toISOString();

    const token = localStorage.getItem('token');

    const response = await fetch('/api/meditation/log/', {
        method: 'POST',
        headers: {
            'Authorization': `Token ${token}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            duration: parseInt(duration),
            timestamp: formattedTimestamp,  // ✅ Send user-selected timestamp
            activity_type: "meditation"
        })
    });

    if (response.ok) {
        alert('Meditation logged successfully!');
        window.location.href = '/meditation/history/';
    } else {
        alert('Failed to log meditation.');
    }
});
