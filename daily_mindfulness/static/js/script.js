
// Index Page
document.addEventListener('DOMContentLoaded', () => {
    const quoteParagraph = document.getElementById('quote');
    const sourceParagraph = document.getElementById('source');
    const loggedOutSection = document.getElementById('loggedOutSection');
    const loggedInSection = document.getElementById('loggedInSection');

    const token = localStorage.getItem('token');
    const username = localStorage.getItem('username');
    // Display appropriate section based on login state
    if (token) {
        loggedOutSection.style.display = 'none';
        loggedInSection.style.display = 'block';

        // Button actions for logged-in users
        document.getElementById('viewHistory').addEventListener('click', () => {
        window.location.href = `/meditation/history/`;
        });

        document.getElementById('logMeditation').addEventListener('click', () => {
            window.location.href = '/meditation/log/';
        });

        document.getElementById('logout').addEventListener('click', () => {
            localStorage.removeItem('token');
            localStorage.removeItem('username');
            window.location.href = '/';
        });
        if (token && username) {
        const welcomeMessage = document.getElementById('welcomeMessage');
        welcomeMessage.textContent = `Hi, ${username}!`; // Set the personalized message
        }
    } else {
        loggedOutSection.style.display = 'block';
        loggedInSection.style.display = 'none';

        // Login button redirects to login.html
        document.getElementById('goToLogin').addEventListener('click', () => {
            window.location.href = '/login/';
        });
    }

    // Fetch the daily quote from the public API

    async function fetchQuote() {
        try {
            const response = await fetch('/api/quote/', {  // Public endpoint
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            if (response.ok) {
                const data = await response.json();
                quoteParagraph.textContent = data.text || "No quote available today.";
                sourceParagraph.textContent = `— ${data.source || "Unknown"}`;
            } else {
                quoteParagraph.textContent = "Failed to fetch the quote.";
                sourceParagraph.textContent = "";
            }
        } catch (error) {
            console.error("Error fetching the quote:", error);
            quoteParagraph.textContent = "An error occurred while fetching the quote.";
            sourceParagraph.textContent = "";
        }
    }

    // Fetch the quote on page load
    fetchQuote();

});

// Login Page
document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm'); // Target the form
    const errorMessage = document.getElementById('errorMessage'); // Target the error message

    if (!loginForm) {
        console.error("Error: loginForm not found in the DOM!");
        return;
    }

    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault(); // Prevent form from refreshing the page

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (!username || !password) {
            errorMessage.textContent = "Please fill out all fields.";
            return;
        }

        try {
            const response = await fetch('/api-token-auth/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ username, password }),
            });

            if (response.ok) {
                const data = await response.json();
                localStorage.setItem('token', data.token); // Store the token
                localStorage.setItem('username', username); // Store the username
                window.location.href = '/'; // Redirect to home page
            } else {
                errorMessage.textContent = "Invalid username or password.";
            }
        } catch (error) {
            console.error("Error:", error);
            errorMessage.textContent = "An error occurred. Please try again.";
        }
    });
});

// Meditation History Display
document.addEventListener('DOMContentLoaded', async () => {
    const token = localStorage.getItem('token');
    const username = localStorage.getItem('username');

    if (!token  || !username) {
        console.error("Token or Username is missing", error);
        return;
    }

    try {
        // Fetch logs for the user
        const response = await fetch(`/api/meditation/logs/${username}/`, {
            headers: { 'Authorization': `Token ${token}`, 'Content-Type': 'application/json' }
        });

        if (response.ok) {
            const logs = await response.json();
            const tableBody = document.querySelector('#meditationLogs tbody');

            // Clear previous logs
            tableBody.innerHTML = '';

            // Populate logs
            logs.forEach(log => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${new Date(log.timestamp).toLocaleDateString()}</td>
                    <td>${log.duration} mins</td>
                    <td>${log.activity_type}</td>
                `;
                tableBody.appendChild(row);
            });
        } else {
            console.error("Failed to load meditation logs.");
        }
    } catch (error) {
        console.error("Error fetching logs:", error);
    }

    // Back to Dashboard button
    document.getElementById('backToDashboard').addEventListener('click', () => {
        window.location.href = '/';
    });
});
document.addEventListener('DOMContentLoaded', async () => {
    const token = localStorage.getItem('token');
    if (!token) {
        alert('You need to be logged in to view this page.');
        window.location.href = '/';
        return;
    }

    const response = await fetch('/api/meditation/log/', {
        method: 'GET',
        headers: {
            'Authorization': `Token ${token}`,
            'Content-Type': 'application/json',
        },
    });

    if (response.ok) {
        const logs = await response.json();
        populateTable(logs);
        generateChart(logs);
    } else {
        console.error('Failed to fetch meditation logs');
    }
});

// Populate the table with logs
function populateTable(logs) {
    const tbody = document.querySelector('#meditationLogs tbody');
    tbody.innerHTML = ''; // Clear previous entries

    logs.forEach(log => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${new Date(log.timestamp).toLocaleDateString()}</td>
            <td>${log.duration}</td>
            <td>${log.activity_type}</td>
        `;
        tbody.appendChild(row);
    });
}

// Generate Chart.js visualization
function generateChart(logs) {
    const ctx = document.getElementById('meditationChart').getContext('2d');

    // Aggregate data for chart
    const dates = logs.map(log => new Date(log.timestamp).toLocaleDateString());
    const durations = logs.map(log => log.duration);

    // Create a unique color for each bar
    const colors = durations.map((_, index) => {
        const hue = (index * 30) % 360; // Vary hue for each bar
        return `hsl(${hue}, 70%, 50%)`; // HSL format for dynamic colors
    });

    // Create Chart
    new Chart(ctx, {
        type: 'bar', // Bar chart to visualize durations
        data: {
            labels: dates,
            datasets: [{
                label: 'Meditation Duration (mins)',
                data: durations,
                backgroundColor: 'rgba(240, 230, 196, 1)',
                borderColor: 'rgba(240, 230, 196, 1)',
                borderWidth: 1,
            }],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                },
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Date',
                    },
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Duration (minutes)',
                    },
                },
            },
        },
    });
}

// Meditation Logging

document.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token');
    if (!token) {
        console.error("Token is missing", error);
        return;
    }
    console.log("Token retrieved:", token);

    const logMeditationForm = document.getElementById('logMeditationForm');
    const errorMessage = document.getElementById('errorMessage');

    logMeditationForm.addEventListener('submit', async (event) => {
        event.preventDefault(); // Prevent default form submission

        const duration = document.getElementById('duration').value;
        const date = document.getElementById('date').value;

        if (!duration || !date) {
            document.getElementById('errorMessage').textContent = "All fields are required.";
            return;
        }

        try {
            // Prepare the payload
            const payload = {
                activity_type: "meditation",
                duration: parseInt(duration),
                timestamp: new Date(date).toISOString(),
            };

            // Send the POST request
            const response = await fetch('/api/meditation/log/', {
                method: 'POST',
                headers: {
                    'Authorization': `Token ${token}`, // Attach the token
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(payload), // Send only the required fields
            });

            if (response.ok) {
                alert("Meditation logged successfully!");
                window.location.href = '/'; // Redirect to the dashboard
            } else {
                const errorData = await response.json();
                errorMessage.textContent = errorData.detail || "Failed to log meditation.";
            }
        } catch (error) {
            console.error("Error logging meditation:", error);
            errorMessage.textContent = "An error occurred. Please try again.";
        }
    });
    // Back to Dashboard button
    document.getElementById('backToDashboard').addEventListener('click', () => {
    window.location.href = '/';
    });
});

document.addEventListener('DOMContentLoaded', () => {
    let timerInterval;
    let elapsedTime = 0; // Time in seconds

    const timerDisplay = document.getElementById('timerDisplay');
    const startTimerButton = document.getElementById('startTimer');
    const pauseTimerButton = document.getElementById('pauseTimer');
    const saveTimerButton = document.getElementById('saveTimer');

    // Format time as HH:MM:SS
    const formatTime = (seconds) => {
        const hrs = String(Math.floor(seconds / 3600)).padStart(2, '0');
        const mins = String(Math.floor((seconds % 3600) / 60)).padStart(2, '0');
        const secs = String(seconds % 60).padStart(2, '0');
        return `${hrs}:${mins}:${secs}`;
    };

    // Update the timer display
    const updateDisplay = () => {
        timerDisplay.textContent = formatTime(elapsedTime);
    };

    // Start the timer
    startTimerButton.addEventListener('click', () => {
        startTimerButton.disabled = true;
        pauseTimerButton.disabled = false;
        saveTimerButton.disabled = true;

        timerInterval = setInterval(() => {
            elapsedTime++;
            updateDisplay();
        }, 1000);
    });

    // Pause the timer
    pauseTimerButton.addEventListener('click', () => {
        clearInterval(timerInterval);
        startTimerButton.disabled = false;
        pauseTimerButton.disabled = true;
        saveTimerButton.disabled = false;
    });

    // Save the timer to the backend
    saveTimerButton.addEventListener('click', async () => {
        const token = localStorage.getItem('token'); // Retrieve the user's token
        if (!token) {
            alert('You must be logged in to save your meditation session.');
            return;
        }

        try {
            const response = await fetch('/api/meditation/log/', {
                method: 'POST',
                headers: {
                    'Authorization': `Token ${token}`,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    activity_type: 'meditation',
                    duration: Math.floor(elapsedTime / 60), // Convert seconds to minutes
                    timestamp: new Date().toISOString(),
                }),
            });

            if (response.ok) {
                alert('Meditation session logged successfully!');
                elapsedTime = 0; // Reset the timer
                updateDisplay();
                startTimerButton.disabled = false;
                pauseTimerButton.disabled = true;
                saveTimerButton.disabled = true;
            } else {
                const errorData = await response.json();
                console.error('Error saving session:', errorData);
                alert('Failed to save the meditation session.');
            }
        } catch (error) {
            console.error('Error logging meditation:', error);
            alert('An error occurred while logging your meditation.');
        }
    });
});
document.addEventListener('DOMContentLoaded', () => {
    const dateInput = document.getElementById('date');
    if (dateInput) {
        const today = new Date().toISOString().split('T')[0]; // Get today's date in YYYY-MM-DD format
        dateInput.value = today; // Set the default value
    }
});

