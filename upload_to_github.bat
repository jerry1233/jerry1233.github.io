git config --global http.proxy http://127.0.0.1:8118
git add .
git commit -m "firest commit"

git remote set-url origin https://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@github.com/jerry1233/jerry1233.github.io.git
git push -u origin main
git config --global --unset http.proxy
pause