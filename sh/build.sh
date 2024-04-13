#!/bin/bash
mkdir build
cd build
shx echob Building Go projects...
bash ../lang/go.sh
shx echob Setting Windows executables...
ls -1 *_windows_* | while IFS= read -r file; do
	mv "${file}" "${file}.exe"
done
shx echob Generating hashes...
sha384sum * > hashes.txt
exit