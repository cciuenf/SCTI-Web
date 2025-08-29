#!/usr/bin/env bash

cd 
echo scti | sudo -S rm -rf .nix-profile/bin/android-studio
echo scti | sudo -S rm -rf .nix-profile/bin/docker-compose 
echo scti | sudo -S rm -rf .nix-profile/bin/docker
echo scti | sudo -S rm -rf .nix-profile/bin/dockerd 
echo scti | sudo -S rm -rf .nix-profile/bin/dockerd-rootless 
echo scti | sudo -S apt-get update
echo scti | sudo -S apt install -y python3-pip 
pip install pyspark --break-system-packages 
echo scti | sudo -S snap docker 
echo my-app | npx create-expo-app@latest --template default 
cd my-app 
echo "^C" | npm start 
cd 
