#!/usr/bin/env sh
#
# name: Restart
# icon: system-restart
# description: Reboot the system
# keywords: power reboot restart

set -eu

is_gnome() {
  command -v dbus-send >/dev/null && \
    command -v gnome-session-quit >/dev/null && \
    dbus-send --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.freedesktop.DBus.Properties.Get string:org.gnome.Shell string:ShellVersion >/dev/null 2>&1
}

is_cosmic() {
  command -v cosmic-osd >/dev/null && [ "$XDG_SESSION_DESKTOP" = "COSMIC" ]
}

if is_cosmic; then
  cosmic-osd restart
elif is_gnome; then
  gnome-session-quit --reboot
elif command -v systemctl >/dev/null; then
  systemctl reboot
fi
