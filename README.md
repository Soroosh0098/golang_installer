# Go Installer Script

This repository contains a versatile Bash script that automates the installation of the Go programming language across different operating systems. The script dynamically detects the user's operating system, scrapes the latest Go download links from the official [Go downloads page](https://go.dev/dl/), and installs the appropriate version of Go based on the user's environment.

## Features:
- **Cross-Platform Support**: Automatically detects and supports installation on Linux, macOS (both ARM64 and x86-64), and Windows.
- **Automated Download and Installation**: Scrapes the official Go download page to fetch the latest release links, ensuring you're always installing the most recent version.
- **Environment Setup**: Configures the system path on Linux to include the Go binary directory for seamless usage post-installation.
- **Silent Installation on Windows**: Utilizes the MSI installer for Go, allowing for silent, automated installations with minimal user interaction.

## How It Works:
1. **OS Detection**: The script identifies the operating system using `uname` and selects the appropriate download link.
2. **Download and Install**: The script downloads the relevant Go package, handles extraction/installation, and sets up the environment as needed.
3. **Error Handling**: Includes robust error handling to manage download failures, incorrect file formats, and unsupported operating systems.

## Usage:
#### Execute the Script Directly

To execute the script directly on your server, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/Soroosh0098/golang_installer/main/golang_installer.sh | sudo bash
```

#### Download the Script

To download the script, you can use either curl or wget. Run one of the following commands in your terminal:

Using curl:

```
curl -o install.sh -L https://raw.githubusercontent.com/Soroosh0098/golang_installer/main/golang_installer.sh
```

Using wget:

```
wget https://raw.githubusercontent.com/your-username/golang_installer/main/install.sh -O golang_installer.sh
```

**Install the Project**: Once downloaded, make the script executable and run it to install the project:

```
chmod +x golang_installer.sh
./golang_installer.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
