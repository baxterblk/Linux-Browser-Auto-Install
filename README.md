# Linux Browser Auto-Install Script

This script automates the installation of popular web browsers on various Linux distributions. It supports the latest versions of **Google Chrome**, **Brave**, **Firefox**, and **Vivaldi**, and has been designed to work on common Linux distributions such as Ubuntu, Debian, Fedora, CentOS, Red Hat Enterprise Linux (RHEL), and AlmaLinux.

## Supported Browsers
- Google Chrome
- Brave Browser
- Firefox
- Vivaldi

## Supported Linux Distributions
- Ubuntu
- Debian
- Fedora
- CentOS Linux
- Red Hat Enterprise Linux (RHEL)
- AlmaLinux

## Requirements
- You must have `sudo` privileges on your system, as the script requires administrative permissions to install the browsers.
- `bash` (usually installed by default on most Linux distributions)

## How It Works

1. **OS Detection**: The script first checks your operating system to ensure it is supported.
2. **Install Dependencies**: It then installs the required dependencies (such as `wget`, `gnupg`, etc.) for the system to fetch and install browser packages.
3. **Select Browser**: You'll be prompted to choose a browser from the four options — Google Chrome, Brave, Firefox, or Vivaldi.
4. **Browser Installation**: The script installs your selected browser, ensuring it's added to the appropriate repositories and properly configured.
  
## Installation & Usage

### Clone the repository
To use the script, start by cloning this repository to your local machine:

```bash
git clone https://github.com/baxterblk/Linux-Browser-Auto-Install.git
cd Linux-Browser-Auto-Install
```

### Running the Script
Run the script using the following command:

```bash
./browser-install.sh
```

You will be guided through the following steps:

1. **Dependency Installation**: The script will prompt you to install any necessary dependencies. It is highly recommended to type `yes` here to proceed.
   
2. **Browser Selection**: A prompt will allow you to choose one of the following browsers to install:
   - Google Chrome
   - Brave Browser
   - Firefox
   - Vivaldi

3. **Completion**: Once the browser is installed, the script will print a confirmation message.

### Example

```bash
$ ./browser-install.sh
Detected OS: Ubuntu
Would you like to install the required dependencies for this script to run? (yes/no): yes
Installing dependencies...
Which browser would you like to install?
1) Google Chrome
2) Brave Browser
3) Firefox
4) Vivaldi
5) None
6) Quit
# Enter the number corresponding to your browser choice
```  

## Important Notes
- The script supports popular browser repositories and download locations. If any of these sources change or are unavailable, the installation may fail, requiring updates to the script.
  
- Use `sudo` carefully. This script installs packages with elevated privileges (via `sudo`), so ensure you trust the source.

## Supported Commands
- **Google Chrome**: Installs the Chrome browser directly from the official Google repository.
- **Brave Browser**: Adds the Brave browser repository and installs it.
- **Firefox**: Uses the default package manager to install Firefox from your distribution's repository.
- **Vivaldi**: Configures the official Vivaldi repository and installs it.

## Contributions & Issues
If you encounter any issues or would like to contribute to this project:
- Open an [issue](https://github.com/baxterblk/Linux-Browser-Auto-Install/issues) on the GitHub repository.
- Feel free to submit a pull request if you've made an improvement to the script.

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the `LICENSE` file for details.

## Disclaimer
This script is provided as-is. While it has been tested on major Linux distributions, you should use it at your own risk. Always review script content before running on your system.

---

Enjoy seamless browser installation on your favorite Linux distribution! 😎
