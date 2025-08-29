cd
echo scti | sudo -S rm -rf .nix-profile/bin/android-studio
echo scti | sudo -S apt install -y python3-pip 
pip install pyspark --break-system-packages
echo scti | sudo -S apt install -y docker
echo my-app | npx create-expo-app@latest --template default
cd my-app
echo "^C" | npm start
cd
