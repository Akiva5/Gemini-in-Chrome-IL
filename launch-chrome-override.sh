#!/bin/bash
# macOS/Linux script to launch Chrome with a geo-variation country override
# ⚠️ AI-Generated Script. Run at your own risk. Author has not executed this code.

echo "Closing existing Google Chrome instances..."
pkill -az "Google Chrome"
sleep 1

echo "Launching Google Chrome with temporary US country code override..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open -n -a "Google Chrome" --args --variations-override-country=us
else
    # Linux
    google-chrome --variations-override-country=us &
fi

echo "Done. If Gemini (Glic) is missing, make sure English (US) is set as your default language in chrome://settings/languages."