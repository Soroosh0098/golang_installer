#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

url="https://go.dev/dl/"

html=$(curl -s $url)

hrefs=$(echo "$html" | grep -oP '<a class="download downloadBox" href="\K[^"]+')

windows_link=""
macos_arm64_link=""
macos_amd64_link=""
linux_link=""
source_link=""

for href in $hrefs; do
    if [[ $href == *windows* ]]; then
        windows_link="https://go.dev$href"
    elif [[ $href == *darwin-arm64* ]]; then
        macos_arm64_link="https://go.dev$href"
    elif [[ $href == *darwin-amd64* ]]; then
        macos_amd64_link="https://go.dev$href"
    elif [[ $href == *linux* ]]; then
        linux_link="https://go.dev$href"
    elif [[ $href == *src* ]]; then
        source_link="https://go.dev$href"
    fi
done

os_name=$(uname -s)
download_link=""

case "$os_name" in
Linux*)
    info "Detected OS: Linux"
    download_link="$linux_link"
    ;;
Darwin*)
    if [[ $(uname -m) == "arm64" ]]; then
        info "Detected OS: macOS (ARM64)"
        download_link="$macos_arm64_link"
    else
        info "Detected OS: macOS (x86-64)"
        download_link="$macos_amd64_link"
    fi
    ;;
CYGWIN* | MINGW* | MSYS*)
    info "Detected OS: Windows"
    download_link="$windows_link"
    ;;
*)
    error "Unknown or unsupported OS: $os_name"
    exit 1
    ;;
esac

install_go() {
    local url=$1
    info "Downloading Go from: $url"

    temp_dir=$(mktemp -d)
    cd "$temp_dir" || exit

    curl -O -L "$url"

    filename=$(basename "$url")

    case "$filename" in
    *.msi)
        info "Installing Go on Windows..."
        warning "I hadn't implemented this part yet :)"
        ;;
    *.pkg)
        info "Installing Go on macOS..."
        sudo installer -pkg "$filename" -target /
        ;;
    *.tar.gz)
        info "Installing Go on Linux..."
        tar -xzf "$filename"
        sudo chown -R root:root ./go
        sudo mv -v go /usr/local
        echo "export GOPATH=$HOME/go" >>~/.bash_profile
        echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >>~/.bash_profile
        source ~/.bash_profile
        go version
        ;;
    *)
        error "Unknown file type: $filename"
        ;;
    esac

    cd ~
    rm -rf "$temp_dir"
}

if [[ -n "$download_link" ]]; then
    install_go "$download_link"
    success "Latest version of Golang installed successfully."
    reboot
else
    error "No download link found for your OS."
    exit 1
fi
