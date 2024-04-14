#!/bin/bash
mkdir build
cd build
../shx echob Building Go projects...
bash ../lang/go.sh
../shx echob Setting Windows executables...
ls -1 *_windows_* | while IFS= read -r file; do
	mv "${file}" "${file}.exe"
done
rm index.htm
../shx echob Compressing files...
ls -1 | while IFS= read -r file; do
	if [[ "$file" == *".bz2" ]]; then
		rm -f "$file"
	else
		bzip2 -9 "$file"
	fi
done
../shx echob Generating web page...
bash ../lang/page.sh
exit