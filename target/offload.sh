#!/bin/bash
mkdir -p build
cd build
curl -Lo ../build/caddy-linux-amd64 "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
curl -Lo ../build/caddy-linux-arm64 "https://caddyserver.com/api/download?os=linux&arch=arm64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
curl -Lo ../build/caddy-windows-amd64 "https://caddyserver.com/api/download?os=windows&arch=amd64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
curl -Lo ../build/caddy-windows-arm64 "https://caddyserver.com/api/download?os=windows&arch=arm64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
cd ..
bash ./shx post
exit