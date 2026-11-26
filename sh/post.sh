#!/bin/bash
ls -1 *_windows_* 2>/dev/null | while IFS= read -r file; do
	mv -v "${file}" "${file}.exe" 2>/dev/null
done
ls -1 *-windows-* 2>/dev/null | while IFS= read -r file; do
	mv -v "${file}" "${file}.exe" 2>/dev/null
done
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
exit