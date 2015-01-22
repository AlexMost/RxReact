#!/bin/sh

gulp deploy &&
rm -rf ../dist &&
mv dist ../dist &&
git checkout gh-pages &&
mv dist ../dist/* . &&
rm -r ../dist &&
git add . &&
git push