touch "repo1/spamfile.txt"
echo "spam " >> "repo1/spamfile.txt"
git pull 
git add .
git commit -m "fill bytes"
git push --force origin master

printf "akan di lanjutkan 6 jam"
sleep 21600
start test1.sh
