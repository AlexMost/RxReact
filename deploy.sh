#!/bin/sh

gulp deploy && 
mv dist ../ &&
git checkout gh-pages &&
mv dist ../dist . &&
git add . &&
git push