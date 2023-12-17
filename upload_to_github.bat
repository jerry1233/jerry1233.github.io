git config --global http.proxy http://127.0.0.1:8118
git add .
git commit -m "firest commit"

git push -u origin main -f
git config --global --unset http.proxy
pause