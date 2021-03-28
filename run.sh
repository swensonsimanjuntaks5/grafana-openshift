sudo useradd -m swenson
sudo adduser swenson sudo
echo "swenson:123456" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
sudo apt install --assume-yes xscreensaver
sudo hostname swenson
sudo adduser swenson
sudo apt install tightvncserver
echo -e "no\n123456\n123456" | tightvncserver :1
#echo -e "112233\n112233" | su - swenson -c """DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g4cfExPsBwTL9HHyQqfRVLHIBpQrkaW96wSh0yJI6WUKNQ46p7rn8dswO6osj-kWg" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"""

if [[ -z "1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g" ]]; then
  echo "Please set '1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g'"
  exit 2
fi

if [[ -z "123456" ]]; then
  echo "Please set '123456' for user: swenson"
  exit 3
fi

echo "### Install ngrok ###"

wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok

echo "### Update user: swenson password ###"
echo -e "123456\n123456" | sudo passwd "swenson"

echo "### Start ngrok proxy for 22 port ###"


rm -f .ngrok.log
./ngrok authtoken "1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g"
./ngrok tcp 80  --log ".ngrok.log" &

sleep 10
HAS_ERRORS=$(grep "command failed" < .ngrok.log)

if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "=========================================="
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh swenson@/" | sed "s/:/ -p /")"
  echo "Connect with remote desktop: https://remotedesktop.google.com/access"
  echo "=========================================="
else
  echo "$HAS_ERRORS"
  exit 4
fi
