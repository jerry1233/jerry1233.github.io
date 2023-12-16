git config --global http.proxy http://127.0.0.1:8118
git add .
git commit -m "firest commit"

git remote set-url origin https://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@github.com/jerry1233/jerry1233.github.io.git
git push -u origin main -f
git config --global --unset http.proxy
pause