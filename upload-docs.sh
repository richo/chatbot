#!/bin/bash

# Make a new repo for the gh-pages branch
rm -rf .gh-pages
mkdir .gh-pages
cd .gh-pages
git init

# Copy over the documentation
cp -r ../target/doc/* .
cp ../circle.yml ./

# Add, commit and push files
if [ ${CIRCLECI} ]
then
    git config user.name "Joe Wilm"
    git config user.email "joe@jwilm.com"
fi
git checkout -b gh-pages
echo "chatbot.rs" > CNAME
git add -f --all .
git commit -m "Documentation"
git remote add origin https://github.com/jwilm/chatbot.git
git push -qf origin gh-pages

# Cleanup
cd ..
rm -rf .gh-pages
