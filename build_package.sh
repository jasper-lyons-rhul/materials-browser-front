#!/bin/sh -e

set -x

root=$(pwd)

if [ ! -d "node_modules" ]
then
    npm install
fi

ng build --configuration production
mkdir -p dist/materials-browser-front

if [ ! -d "../materials-browser-api" ]
then 
    git clone https://github.com/FAIRsFAIR/materials-browser-api.git ../materials-browser-api
    cd ../materials-browser-api
    composer install
    cd -
fi

cp -r ../materials-browser-api dist/materials-browser-front/api | true
cd dist/materials-browser-front/api
rm -rf .idea .gitlab-ci.yaml .gitignore .git var nbproject
cd ..
zip -r materials-browser.zip *

mv materials-browser.zip $root
