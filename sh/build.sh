#!/bin/bash
mkdir -p build
cd build
../shx echob Building Go projects...
#bash ../lang/go.sh
curl -Lo ../build/caddy-linux-amd64 "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
curl -Lo ../build/caddy-linux-arm64 "https://caddyserver.com/api/download?os=linux&arch=arm64&p=github.com%2Fporech%2Fcaddy-maxmind-geolocation&p=github.com%2Fltgcgo%2Ffloaty"
../shx echob Setting Windows executables...
ls -1 *_windows_* | while IFS= read -r file; do
	mv "${file}" "${file}.exe"
done
rm index.htm
../shx echob Compressing files...
ls -1 | while IFS= read -r file; do
	if [[ "$file" == *".br" ]]; then
		rm -f "$file"
	elif [[ "$file" == *".zst" ]]; then
		rm -f "$file"
	elif [[ "$file" == *".gz" ]]; then
		rm -f "$file"
	else
		brotli -jv9 "$file"
	fi
done
#../shx echob Generating web page...
#bash ../lang/page.sh
exit