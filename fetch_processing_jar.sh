#!/bin/bash

# Define global constants for URLs
URL_LINUX64="https://py.processing.org/processing.py-linux64.tgz" 
URL_LINUX32="https://py.processing.org/processing.py-linux32.tgz"
URL_MAC="https://py.processing.org/processing.py-macosx.tgz"
URL_WINDOWS64="https://py.processing.org/processing.py-windows64.zip"
URL_WINDOWS32="https://py.processing.org/processing.py-windows32.zip"

# Detect the operating system
OS="unknown"
case "$(uname -s)" in
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*|MINGW*|MSYS*) OS="Windows";;
    *)          OS="UNKNOWN";;
esac

# Detect the architecture
ARCH=$(uname -m)
URL=""

if [ "$OS" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ] || [ "$ARCH" == "aarch64" ]; then
        URL="$URL_LINUX64"
    elif [ "$ARCH" == "i386" ] || [ "$ARCH" == "i686" ]; then
        URL="$URL_LINUX32"
    fi
elif [ "$OS" == "Mac" ]; then
    URL="$URL_MAC"
elif [ "$OS" == "Windows" ]; then
    # Assuming WSL for Windows
    if [ "$ARCH" == "x86_64" ]; then
        URL="$URL_WINDOWS64"
    else
        URL="$URL_WINDOWS32"
    fi
fi

if [ -z "$URL" ]; then
    echo "Unsupported OS or architecture: $OS $ARCH" >&2
    exit 1
fi

echo "Downloading Processing.py for $OS ($ARCH)"
wget -O processing.py-archive "$URL" && tar -xvzf processing.py-archive -C /usr/src/app