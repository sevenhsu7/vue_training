#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 构建
npm run build

# 进入构建输出目录
cd dist

# 删除之前的 Git 仓库以确保清洁部署
rm -rf .git

git init
git add -A
git commit -m 'deploy'

# 如果你想要部署到 https://sevenhsu7.github.io/vue_training
git push -f git@github.com:sevenhsu7/vue_training.git main:gh-pages

cd - 