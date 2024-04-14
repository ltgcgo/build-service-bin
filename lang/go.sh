#!/bin/bash
cat ../lang/go.txt | while IFS= read -r line; do
	export GOOS=$(printf $line | cut -d'_' -f1)
	export GOARCH=$(printf $line | cut -d'_' -f2)
	echo Building Caddy in ${GOOS} ${GOARCH}...
	xcaddy build --with github.com/porech/caddy-maxmind-geolocation --with github.com/lolPants/caddy-requestid --with github.com/ltgcgo/floaty
	mv caddy "caddy_${GOOS}_${GOARCH}"
	rm -rf ~/.cache/go-build
done
exit