#! /bin/sh

swift build -c release
cd .build/release
cp -f ytbDown /usr/local/bin/ytbDown
cp -f ytbDown /usr/local/bin/ytbdown