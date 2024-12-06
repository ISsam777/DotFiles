#!/bin/bash
##colors ---
C1='\033[1;34m'
C2='\033[1;35m'

echo -e "${C1} choose a package manager :"
echo "                                       "

echo "1) Arch   "
echo "2) debian	"
echo "3) fedora "
echo "          "
read pkg

case $pkg in
1)
echo -e "${C1} updating the system..."
pacman -Syu

echo -e "${C1} installing dependencies..."
pacman -Sy fzf yazi neovim kitty i3 autotiling git fish starship btop polybar stow firefox picom
yay -S dragon-drop
;;
2)
echo -e "${C1} updating the system..."
apt update && apt upgrade 

echo -e "${C1} installing dependencies..."
apt install  fzf neovim kitty i3 autotiling git eza zoxide bat fish btop polybar stow yazi starship 
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install yazi  starship

;;
3)
echo -e "${C1} updating the system..."

sudo dnf upgrade --refresh && sudo dnf system-upgrade download --releasever=41

echo -e "${C1} installing dependencies..."

dnf install fzf yazi neovim kitty i3 zoxide exa autotiling git bat fish starship btop polybar stow --skip-unavailable
dnf install dragon
;;
  *)
    ;;
esac


## using stow to copy dotfiles in .config
echo -e "${C2} copying dotfiles.... "
cd .config/
stow . --adopt

####  remember to make changes in dotfiles  and it will change automaticly in ~/.config
