#!/usr/bin/env bash

set -eu

gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
#gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface cursor-blink false
gsettings set org.gnome.desktop.interface cursor-size 64
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 12"
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell false

# General gnome-terminal Settings
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant dark

profile=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-blink-mode off
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-shape block
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ font 'Monospace 12'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ foreground-color '#FFFFFF'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ scrollbar-policy never
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ visible-name default

# Enumerate all possible settings
# gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ | sort
