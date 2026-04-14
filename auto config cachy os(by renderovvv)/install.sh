#!/bin/bash

echo "Обновление системы..."
sudo pacman -Syu --noconfirm

echo "Включаем multilib (для Steam)..."
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Sy

echo "Установка пакетов..."
sudo pacman -S --noconfirm $(cat packages.txt)

echo "Включение сервисов..."
sudo systemctl enable sddm
sudo systemctl enable --now gamemoded
sudo systemctl enable fstrim.timer

echo "Установка yay (AUR)..."
sudo pacman -S --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

echo "Установка конфигов Hyprland..."
mkdir -p ~/.config/hypr
cp -r hypr/* ~/.config/hypr/ 2>/dev/null

echo "Установка конфигов KDE..."
mkdir -p ~/.config
cp -r kde/* ~/.config/ 2>/dev/null

echo "Готово"
echo "Сделано by renderovvv"