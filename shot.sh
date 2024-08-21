#!/usr/bin/bash

# Function to install packages and handle errors
install_packages() {
    sudo apt-get update
   

 sudo apt-get install -y bspwm nemo kitty alacritty ranger xdg-user-dirs xdg-user-dirs-gtk sxhkd polybar rofi
xdg-user-dirs-update
xdg-user-dirs-gtk-update

 sudo apt-get install -y feh xclip i3lock-fancy scrot scrub maim ffmpeg wmname imagemagick htop neofetch python3-pip 
sleep 3
 sudo apt-get install -y procps tty-clock fzf lsd bat pamixer flameshot build-essential git
sleep 3
 sudo apt-get install -y libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev 
sleep 3
 sudo apt-get install -y libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev 
sleep 3
 sudo apt-get install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-composite0-dev 
sleep 3
 sudo apt-get install -y python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev 
sleep 3
 sudo apt-get install -y libxcb-xrm-dev libxcb-cursor-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev 
sleep 3
 sudo apt-get install -y libnl-genl-3-dev xorg xserver-xorg xbacklight xbindkeys xvkbd xinput policykit-1-gnome 
sleep 3
 sudo apt-get install -y network-manager network-manager-gnome nemo gvfs file-roller lxappearance dialog mtools 
sleep 3
 sudo apt-get install -y dosfstools avahi-daemon gvfs-backends gnome-power-manager net-tools pulseaudio pavucontrol 
sleep 3
 sudo apt-get install -y pamixer pulsemixer udiskie udisks2 exa lz4 notepadqq w3m gvfs-fuse wmctrl brightnessctl 
sleep 3
 sudo apt-get install -y playerctl mpc p7zip-full meson libxext-dev libxcb-damage0-dev libpixman-1-dev libdbus-1-dev 
sleep 3
 sudo apt-get install -y libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev 
sleep 3
 sudo apt-get install -y libx11-xcb-dev libxcb-glx0-dev xclip ttyoclock papirus-icon-theme zip unzip geany vlc 
sleep 3 
sudo apt-get install -y alacritty lolcat rxvt-unicode zenity yad dex cmus arc-theme ascii toilet toilet-fonts figlet 
sleep 3 
sudo apt-get install -y sxhkd suckless-tools airmon-ng jq yq autoconf automake cava font-downloader font-manager 
sleep 3 
sudo apt-get install -y thefuck util-linux gcc bc libjpeg-dev ffmpegthumbnailer exiftool mcomix fonts-recommended 
sleep 3 
sudo apt-get install -y fonts-font-awesome fonts-terminus fonts-noto fonts-oxygen smartmontools ninja-build

# Install picom
echo -e "\n${purpleColour}[*] Installing picom...\n${endColour}"
git clone https://github.com/ibhagwan/picom.git
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
if [ $? != 0 ] && [ $? != 130 ]; then
    echo -e "\n${redColour}[-] Failed to install picom!\n${endColour}"
else
    echo -e "\n${greenColour}[+] Picom installed\n${endColour}"
fi
cd
sleep 30
# Setup dotfiles
echo -e "\n${purpleColour}[*] Setting up dotfiles...\n${endColour}"
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/r1vs3c/dotfiles.git
cp -r dotfiles/* ~/.config/
echo -e "\n${greenColour}[+] Dotfiles set up\n${endColour}"
sleep 30
# Install Nerd Fonts
echo -e "\n${purpleColour}[*] Installing Nerd Fonts...\n${endColour}"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip
unzip Hack.zip
fc-cache -fv
echo -e "\n${greenColour}[+] Nerd Fonts installed\n${endColour}"
sleep 3o
# Set bash as the default shell
chsh -s /bin/bash
echo -e "\n${greenColour}[+] Bash configured as the default shell\n${endColour}"
sleep 30
# Install LightDM and configure Slick Greeter
install_packages lightdm lightdm-gtk-greeter slick-greeter
sudo sed -i 's/^#greeter-hide-users=false/greeter-hide-users=false/' /etc/lightdm/lightdm.conf
echo "[Seat:*]
user-session=bspwm
greeter-session=slick-greeter" | sudo tee /etc/lightdm/lightdm.conf.d/20-defaults.conf
echo -e "\n${greenColour}[+] Slick Greeter installed and configured with bspwm as the default desktop environment.${endColour}"

echo -e "\n${yellowColour}[*] All done! Reboot your system to apply the changes.${endColour}\n"
