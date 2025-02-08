let aiData = [];

document.addEventListener("DOMContentLoaded", async function () {
    const token = localStorage.getItem("token");

    if (!token) {
        console.error("Authentication token not found!");
        return;
    }

    try {
        const response = await fetch("/api/combined-data/", {
            headers: { Authorization: `Token ${token}` },
        });

        if (!response.ok) {
            throw new Error("Failed to fetch combined data");
        }

        // Fetch AI insights from backend
        const aiResponse = await fetch("/api/ai-analysis/", {
            headers: { Authorization: `Token ${token}` },
        });

        if (!aiResponse.ok) {
            throw new Error("Failed to fetch AI insights");
        }

        aiData = await aiResponse.json();
        console.log("🧠 AI Insights:", aiData);

if (aiData.length > 0 && aiData[0].predicted_sleep_score !== undefined) {
    document.getElementById("ai-insights").textContent = `🔬 AI Prediction: ${aiData[0].predicted_sleep_score}`;
} else {
    document.getElementById("ai-insights").textContent = "⚠️ No AI insights available.";
}



        const data = await response.json();
        console.log("🔹 Fetched Data:", data);

        if (data.length === 0) {
            console.error("❌ No data available for chart.");
            return;
        }

        // Convert dates to MM-DD format
        const labels = data.map((entry) => {
            const date = new Date(entry.date);
            return date.toLocaleDateString("en-US", {
                month: "2-digit",
                day: "2-digit"
            }).replace(/\//g, "-"); // Ensure MM-DD format
        });

        // Convert sleep duration to minutes
        function convertToMinutes(timeString) {
            if (!timeString || typeof timeString !== "string") return 0;
            const match = timeString.match(/(\d+)h\s*(\d*)min?/);
            if (!match) return 0;
            const hours = parseInt(match[1], 10) || 0;
            const minutes = parseInt(match[2] || "0", 10);
            return hours * 60 + minutes;
        }

        // Extract data for all metrics
        const meditationDurations = data.map((entry) => entry["duration_y"] || 0);
        const sleepDurations = data.map((entry) => convertToMinutes(entry["duration_x"]));
        const sleepScores = data.map((entry) => entry["score"] || 0);
        const heartRates = data.map((entry) => entry["resting heart rate"] || 0);
        const bodyBattery = data.map((entry) => entry["body battery"] || 0);
        const hrvValues = data.map((entry) => entry["hrv status"] || 0);

        // Chart configuration
        const ctx = document.getElementById("meditationSleepChart").getContext("2d");
        const chart = new Chart(ctx, {
            data: {
                labels: labels,
                datasets: [
                    {
                        type: "bar",
                        label: "Meditation Duration (mins)",
                        data: meditationDurations,
                        borderColor: "rgba(255, 99, 132, 1)",
                        backgroundColor: "rgba(255, 99, 132, 0.2)",
                        yAxisID: "y-meditation",
                    },
                    {
                        type: "line",
                        label: "Sleep Duration (mins)",
                        data: sleepDurations,
                        borderColor: "rgba(54, 162, 235, 1)",
                        backgroundColor: "rgba(54, 162, 235, 0.2)",
                        yAxisID: "y-sleep",
                    },
                    {
                        type: "line",
                        label: "Sleep Score",
                        data: sleepScores,
                        borderColor: "rgba(75, 192, 192, 1)",
                        backgroundColor: "rgba(75, 192, 192, 0.2)",
                        yAxisID: "y-score",
                    },
                    {
                        type: "line",
                        label: "Heart Rate",
                        data: heartRates,
                        borderColor: "rgba(255, 159, 64, 1)",
                        backgroundColor: "rgba(255, 159, 64, 0.2)",
                        yAxisID: "y-heart",
                    },
                    {
                        type: "line",
                        label: "Body Battery",
                        data: bodyBattery,
                        borderColor: "rgba(153, 102, 255, 1)",
                        backgroundColor: "rgba(153, 102, 255, 0.2)",
                        yAxisID: "y-battery",
                    },
                    {
                        type: "line",
                        label: "HRV",
                        data: hrvValues,
                        borderColor: "rgba(255, 206, 86, 1)",
                        backgroundColor: "rgba(255, 206, 86, 0.2)",
                        yAxisID: "y-hrv",
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        title: { display: true, text: "Date" },
                        ticks: {
                            callback: function (value, index, values) {
                                return labels[index]; // Use preformatted MM-DD labels
                            },
                            autoSkip: true,
                            maxRotation: 45,
                            minRotation: 0
                        },
                    },
                    y: {
                        "y-meditation": {
                            type: "linear",
                            position: "left",
                            title: { display: true, text: "Meditation (Minutes)" },
                            ticks: { beginAtZero: true },
                            display: true,
                        },
                        "y-sleep": {
                            type: "linear",
                            position: "right",
                            title: { display: true, text: "Sleep (Minutes)" },
                            ticks: { beginAtZero: true },
                            display: true,
                        },
                        "y-score": {
                            type: "linear",
                            position: "left",
                            title: { display: true, text: "Sleep Score" },
                            ticks: { beginAtZero: true },
                            display: false,
                        },
                        "y-heart": {
                            type: "linear",
                            position: "right",
                            title: { display: true, text: "Heart Rate (BPM)" },
                            ticks: { beginAtZero: true },
                            display: false,
                        },
                        "y-battery": {
                            type: "linear",
                            position: "left",
                            title: { display: true, text: "Body Battery" },
                            ticks: { beginAtZero: true },
                            display: false,
                        },
                        "y-hrv": {
                            type: "linear",
                            position: "right",
                            title: { display: true, text: "HRV" },
                            ticks: { beginAtZero: true },
                            display: false,
                        },
                    },
                },
                plugins: {
                    legend: {
                        display: true,
                        position: "top",
                    },
                    tooltip: {
                        callbacks: {
                            afterBody: function (tooltipItems) {
                                 if (aiData.length > 0 && aiData[0].predicted_sleep_score !== undefined) {
                                    return `🔍 AI Insight: ${aiData[0].predicted_sleep_score}`;
                                } else {
                                    return "No AI insights available";
                                }
                            }
                        }
                    },
                    zoom: {
                        pan: {
                            enabled: true,
                            mode: "x",
                        },
                        zoom: {
                            wheel: { enabled: true },
                            pinch: { enabled: true },
                            mode: "x",
                        },
                    },
                },
            },
        });

        // Toggle function with y-axis control
        function toggleDataset(index, axisId) {
            let dataset = chart.data.datasets[index];
            dataset.hidden = !dataset.hidden;

            // Check if any dataset linked to this axis is visible
            let isAnyDatasetVisible = chart.data.datasets.some(
                (d) => d.yAxisID === axisId && !d.hidden
            );

            // Toggle axis visibility
            if (isAnyDatasetVisible) {
                chart.options.scales[axisId].display = true;
            } else {
                chart.options.scales[axisId].display = false;
            };
            chart.update();
            }

        // Event listeners for toggle buttons
        document.getElementById("toggleMeditation").addEventListener("click", function () {
            toggleDataset(0, "y-meditation");
        });

        document.getElementById("toggleSleep").addEventListener("click", function () {
            toggleDataset(1, "y-sleep");
        });

        document.getElementById("toggleSleepScore").addEventListener("click", function () {
            toggleDataset(2, "y-score");
        });

        document.getElementById("toggleHeartRate").addEventListener("click", function () {
            toggleDataset(3, "y-heart");
        });

        document.getElementById("toggleBodyBattery").addEventListener("click", function () {
            toggleDataset(4, "y-battery");
        });

        document.getElementById("toggleHRV").addEventListener("click", function () {
            toggleDataset(5, "y-hrv");
        });

    } catch (error) {
        console.error("❌ Error fetching or displaying data:", error);
    }
});
