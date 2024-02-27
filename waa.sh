#!/bin/bash

# Variables (Parameterized)
APPIMAGE_NAME="Warp-x86_64.AppImage"
NEW_LOCATION="$HOME/Applications"
APPIMAGE_PATH="$NEW_LOCATION/$APPIMAGE_NAME"
DESKTOP_FILE="$HOME/.local/share/applications/Warp.desktop"
ICON_URL="https://avatars.githubusercontent.com/u/71840468?s=280&v=4"
DOWNLOAD_URL="https://releases.warp.dev/stable/v0.2024.02.20.08.01.stable_02/$APPIMAGE_NAME"

# Check Dependencies (Curl is needed)
if ! command -v curl &> /dev/null; then
    echo "Error: curl is required but it's not installed. Please install curl."
    exit 1
fi

# Verbose Logging and Error Handling?
set -x

function error_exit {
    echo "Error: $1" >&2
    exit 1
}

# Create the Applications directory if it doesn't exist
mkdir -p "$NEW_LOCATION" || error_exit "Failed to create the Applications directory."


curl -o "$HOME/Downloads/$APPIMAGE_NAME" "$DOWNLOAD_URL" || error_exit "Failed to download the AppImage file."

# Move the AppImage to the new location
mv "$HOME/Downloads/$APPIMAGE_NAME" "$APPIMAGE_PATH" || error_exit "Failed to move the AppImage file to the Applications directory."

# Set the executable permission on the AppImage file
chmod +x "$APPIMAGE_PATH" || error_exit "Failed to set executable permission on the AppImage file."

# Download the image and save it as a PNG file
curl -o "$HOME/.local/share/icons/warp_icon.png" "$ICON_URL" || error_exit "Failed to download the icon image."

# Update the Exec field in the desktop file to use the full path
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Type=Application
Name=Warp_Terminal
Exec="$APPIMAGE_PATH"  # Launch the AppImage file
Icon="$HOME/.local/share/icons/warp_icon.png"
Terminal=false  # Do not launch in a terminal
Categories=Utility;
EOF

echo "🚀 Desktop file created successfully. 🌟"

# Disable verbose logging
set +x

echo "🎉 Script executed successfully! 🎉"

echo "Congrats and Happy Warpping :)"
