#!/bin/bash

# Array of supported OSes
supported_oses=("Ubuntu" "Debian GNU/Linux" "Fedora" "CentOS Linux" "Red Hat Enterprise Linux" "AlmaLinux")

# Function to check OS type
check_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        # Check if the OS is supported
        if [[ ! " ${supported_oses[@]} " =~ " ${OS} " ]]; then
            echo "Unsupported OS: ${OS}"
            exit 1
        fi
    else
        echo "Unable to determine OS."
        exit 1
    fi
}

# Function to install dependencies
install_dependencies() {
    case $OS in
        "Ubuntu"|"Debian GNU/Linux")
            sudo apt update
            sudo apt install -y wget gnupg software-properties-common apt-transport-https
            ;;
        "Fedora"|"CentOS Linux"|"Red Hat Enterprise Linux"|"AlmaLinux")
            sudo dnf install -y wget gnupg2
            ;;
        *)
            echo "Unsupported OS: ${OS}"
            exit 1
            ;;
    esac
}

# Function to install Google Chrome
install_chrome() {
    case $OS in
        "Ubuntu"|"Debian GNU/Linux")
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo dpkg -i google-chrome-stable_current_amd64.deb
            sudo apt install -f -y
            ;;
        "Fedora")
            sudo dnf install -y fedora-workstation-repositories
            sudo dnf config-manager --set-enabled google-chrome
            sudo dnf install -y google-chrome-stable
            ;;
        "CentOS Linux"|"Red Hat Enterprise Linux"|"AlmaLinux")
            sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
            ;;
        *)
            echo "Unsupported OS: ${OS}"
            exit 1
            ;;
    esac
}

# Function to install Brave Browser
install_brave() {
    case $OS in
        "Ubuntu"|"Debian GNU/Linux")
            sudo apt install -y apt-transport-https curl
            curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
            sudo apt update
            sudo apt install -y brave-browser
            ;;
        "Fedora")
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install -y brave-browser
            ;;
        "CentOS Linux"|"Red Hat Enterprise Linux"|"AlmaLinux")
            sudo yum install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install -y brave-browser
            ;;
        *)
            echo "Unsupported OS: ${OS}"
            exit 1
            ;;
    esac
}

# Function to install Firefox
install_firefox() {
    case $OS in
        "Ubuntu"|"Debian GNU/Linux")
            sudo apt update
            sudo apt install -y firefox
            ;;
        "Fedora"|"CentOS Linux"|"Red Hat Enterprise Linux"|"AlmaLinux")
            sudo dnf install -y firefox
            ;;
        *)
            echo "Unsupported OS: ${OS}"
            exit 1
            ;;
    esac
}

# Corrected Function to Install Vivaldi
install_vivaldi() {
    case $OS in
        "Ubuntu"|"Debian GNU/Linux")
            wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
            sudo add-apt-repository 'deb [arch=i386,amd64] https://repo.vivaldi.com/archive/deb/ stable main'
            sudo apt update
            sudo apt install vivaldi-stable
            ;;
        "Fedora"|"CentOS Linux"|"Red Hat Enterprise Linux"|"AlmaLinux")
            # Remove any existing Vivaldi repository file
            sudo rm -f /etc/yum.repos.d/vivaldi.repo

            # Re-add the correct Vivaldi repository
            sudo tee /etc/yum.repos.d/vivaldi.repo <<EOF
[vivaldi]
name=vivaldi
baseurl=https://repo.vivaldi.com/archive/rpm/x86_64
gpgkey=https://repo.vivaldi.com/archive/linux_signing_key.pub
enabled=1
gpgcheck=1
EOF

            # Clean and update the repository lists
            sudo dnf clean all
            sudo dnf install vivaldi-stable -y
            ;;
        *)
            echo "Unsupported OS: ${OS}"
            exit 1
            ;;
    esac
}

# Main script
check_os

echo "Detected OS: $OS"
read -p "Would you like to install the required dependencies for this script to run? (yes/no): " confirm
if [[ "$confirm" == "yes" || "$confirm" == "Yes" ]]; then  # Case-insensitive comparison
    install_dependencies
else
    echo "Dependencies are required to continue. Exiting."
    exit 1
fi

echo "Which browser would you like to install?"
options=("Google Chrome" "Brave Browser" "Firefox" "Vivaldi" "None" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Google Chrome")
            install_chrome
            break
            ;;
        "Brave Browser")
            install_brave
            break
            ;;
        "Firefox")
            install_firefox
            break
            ;;
        "Vivaldi")
            install_vivaldi
            break
            ;;
        "None")
            break
            ;;
        "Quit")
            exit 0
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Installation complete."
