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
