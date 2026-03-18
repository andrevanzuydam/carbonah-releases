#!/usr/bin/env bash
# Carbonah installer — downloads the latest release binary for your platform.
#
# Usage:
#   curl -fsSL https://carbonah.dev/install.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/andrevanzuydam/carbonah/main/install.sh | sh

set -e

REPO="andrevanzuydam/carbonah-releases"
INSTALL_DIR="${CARBONAH_INSTALL_DIR:-/usr/local/bin}"

# Detect OS and architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$OS" in
    linux)  OS="linux" ;;
    darwin) OS="darwin" ;;
    *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

case "$ARCH" in
    x86_64|amd64) ARCH="x86_64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *)             echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

ASSET_NAME="carbonah-${OS}-${ARCH}"

echo ""
echo "  Carbonah Installer"
echo "  OS: $OS  Arch: $ARCH"
echo ""

# Get latest release tag
LATEST=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')

if [ -z "$LATEST" ]; then
    echo "  Could not determine latest release."
    echo "  Install from source: cargo install --path crates/carbonah-cli"
    exit 1
fi

echo "  Latest version: $LATEST"

# Download
URL="https://github.com/$REPO/releases/download/$LATEST/${ASSET_NAME}.tar.gz"
echo "  Downloading: $URL"

TMPDIR=$(mktemp -d)
curl -fsSL "$URL" -o "$TMPDIR/carbonah.tar.gz"
tar -xzf "$TMPDIR/carbonah.tar.gz" -C "$TMPDIR"

# Install
if [ -w "$INSTALL_DIR" ]; then
    cp "$TMPDIR/carbonah" "$INSTALL_DIR/carbonah"
else
    echo "  Installing to $INSTALL_DIR (requires sudo)"
    sudo cp "$TMPDIR/carbonah" "$INSTALL_DIR/carbonah"
fi

chmod +x "$INSTALL_DIR/carbonah"
rm -rf "$TMPDIR"

echo ""
echo "  Installed: $INSTALL_DIR/carbonah"
echo "  Version:   $($INSTALL_DIR/carbonah --version 2>/dev/null || echo $LATEST)"
echo ""
echo "  Quick start:"
echo "    carbonah lint ."
echo "    carbonah analyse requirements.txt"
echo "    carbonah measure \"npm run build\""
echo ""
