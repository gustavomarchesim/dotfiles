#!/bin/bash

# Espera 1 segundo para garantir que todos os serviços estão prontos para serem parados
sleep 1

# Mata todos os processos relacionados ao xdg-desktop-portal
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gnome
killall xdg-desktop-portal

# Espera 1 segundo para garantir que todos os processos foram terminados
sleep 1

# Inicia o xdg-desktop-portal-hyprland
if command -v /usr/lib/xdg-desktop-portal-hyprland &> /dev/null
then
    /usr/lib/xdg-desktop-portal-hyprland &
elif command -v /usr/libexec/xdg-desktop-portal-hyprland &> /dev/null
then
    /usr/libexec/xdg-desktop-portal-hyprland &
fi

# Espera 2 segundos, para garantir que o xdg-desktop-portal-hyprland iniciou corretamente
sleep 2

# Inicia o xdg-desktop-portal-gtk
if command -v /usr/lib/xdg-desktop-portal-gtk &> /dev/null
then
    /usr/lib/xdg-desktop-portal-gtk &
elif command -v /usr/libexec/xdg-desktop-portal-gtk &> /dev/null
then
    /usr/libexec/xdg-desktop-portal-gtk &
fi

# Espera 2 segundos para garantir que o xdg-desktop-portal-gtk iniciou corretamente
sleep 2

# Inicia o xdg-desktop-portal
if command -v /usr/lib/xdg-desktop-portal &> /dev/null
then
    /usr/lib/xdg-desktop-portal &
elif command -v /usr/libexec/xdg-desktop-portal &> /dev/null
then
    /usr/libexec/xdg-desktop-portal &
fi

# Espera 2 segundos para garantir que todos os serviços foram iniciados corretamente
sleep 2
