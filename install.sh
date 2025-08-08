#!/bin/bash

# Define the source and destination paths
SCRIPT_NAME="metascan.sh"
DESTINATION="/usr/local/bin/metascan"

# Install required tools
echo "[INFO] Installing required tools..."
# Instalar pacotes Python
pip install binwalk ffmpeg-python --break-system-packages

# Instalar ferramentas de linha de comando
sudo apt update
sudo apt install -y \
    libimage-exiftool-perl \
    imagemagick \
    poppler-utils \
    ffmpeg \
    binwalk


# Copy the script to the destination
sudo cp "$SCRIPT_NAME" "$DESTINATION"

# Ensure the script is executable
sudo chmod +x "$DESTINATION"

# Confirmation message
echo "[INFO] Metascan installed successfully."
echo "[INFO] You can now use it globally with: metascan <file>"
echo "                                         metascan <file> -o/--output meta.txt"
