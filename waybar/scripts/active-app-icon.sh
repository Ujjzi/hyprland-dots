#!/usr/bin/env bash
# active-app-icon.sh
# Gets the focused window class from Hyprland and outputs a Nerd Font icon.
# Falls back to a generic icon for unknown apps.

CLASS=$(hyprctl activewindow -j 2>/dev/null | grep -o '"class": *"[^"]*"' | head -1 | sed 's/"class": *"//;s/"//')

case "${CLASS,,}" in
    # Browsers
    "brave-browser"|"brave")          echo "󰖟" ;;
    "firefox"|"firefox-esr")          echo "󰈹" ;;
    "chromium"|"google-chrome")       echo "" ;;
    "vivaldi"*|"opera")               echo "󰀶" ;;
    "qutebrowser")                    echo "󰖟" ;;

    # Terminals
    "kitty")                          echo "" ;;
    "alacritty")                      echo "" ;;
    "foot")                           echo "󰆍" ;;
    "wezterm")                        echo "" ;;
    "konsole"|"gnome-terminal"|"xterm") echo "" ;;

    # Editors / IDE
    "nvim"|"neovim")                  echo "" ;;
    "code"|"code-oss"|"vscodium")     echo "󰨞" ;;
    "emacs")                          echo "" ;;
    "jetbrains-idea"|"pycharm"*)      echo "" ;;
    "android-studio")                 echo "" ;;
    "zed")                            echo "󰨞" ;;

    # File managers
    "thunar")                         echo "󰝰" ;;
    "nautilus"|"files")               echo "󰝰" ;;
    "dolphin")                        echo "󰝰" ;;
    "nemo")                           echo "󰝰" ;;
    "ranger"|"lf")                    echo "󰝰" ;;

    # Media
    "spotify")                        echo "󰓇" ;;
    "vlc")                            echo "󰕼" ;;
    "mpv")                            echo "" ;;
    "rhythmbox"|"strawberry")         echo "󰎆" ;;

    # Communication
    "discord")                        echo "󰙯" ;;
    "telegram-desktop")               echo "󰔁" ;;
    "slack")                          echo "󰒱" ;;
    "signal")                         echo "󰭹" ;;
    "thunderbird")                    echo "󰇮" ;;
    "whatsapp"*)                      echo "󰖣" ;;

    # System / Tools
    "btop"|"htop"|"nvtop")           echo "󰓅" ;;
    "pavucontrol")                    echo "󰕾" ;;
    "blueman-manager")                echo "󰂯" ;;
    "nm-connection-editor")           echo "󰤨" ;;
    "hyprland"|"waybar")             echo "󰣇" ;;
    "rofi"|"fuzzel")                  echo "" ;;
    "obsidian")                       echo "󱓧" ;;
    "gimp")                           echo "" ;;
    "inkscape")                       echo "" ;;
    "libreoffice"*)                   echo "󰻞" ;;
    "okular"|"zathura"|"evince")      echo "󰈦" ;;
    "steam")                          echo "󰓓" ;;
    "lutris")                         echo "󰺵" ;;
    "virt-manager")                   echo "󰍺" ;;

    # Fallback
    ""|"desktop")                     echo "" ;;
    *)                                echo "󰣆" ;;
esac
