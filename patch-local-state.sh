#!/bin/bash
# macOS/Linux script to patch Chrome's Local State file
# ⚠️ AI-Generated Script. Run at your own risk.

# Define possible paths for Local State
if [[ "$OSTYPE" == "darwin"* ]]; then
    CHROME_PATHS=("$HOME/Library/Application Support/Google/Chrome/Local State")
else
    CHROME_PATHS=(
        "$HOME/.config/google-chrome/Local State"
        "$HOME/.config/chromium/Local State"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/Local State"
    )
fi

CHROME_PATH=""
for path in "${CHROME_PATHS[@]}"; do
    if [ -f "$path" ]; then
        CHROME_PATH="$path"
        break
    fi
done

if [ -z "$CHROME_PATH" ]; then
    echo "Error: Chrome Local State file not found."
    exit 1
fi

echo "Found Local State at: $CHROME_PATH"

echo "Closing Google Chrome instances..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    pkill -f "Google Chrome"
else
    pkill -f "chrome"
fi
sleep 2

# Backup original file
cp "$CHROME_PATH" "$CHROME_PATH.bak"
echo "Backup created at: $CHROME_PATH.bak"

# Replace country codes
# Targets fields like "variations_country", "variations_permanent_consistency_country", etc.
echo "Patching geographical variations from 'IL' to 'US'..."
sed -i.bak -E 's/"(variations_[^"]*country[^"]*)"[[:space:]]*:[[:space:]]*"IL"/"\1":"US"/g' "$CHROME_PATH"

echo "Success! Restart Google Chrome to see changes."
