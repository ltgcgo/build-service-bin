#!/bin/bash
echo '<!DOCTYPE html><head><title>Lightingale Binary Build Service</title><style>body{background:#000;color:#fff;height:100vh;margin:0;padding:8px;}a{color:#3af;}th,td{padding:4px;}</style></head><body><p>Generated on: <i>' > index.htm
printf "$(date)" >> index.htm
echo '</i></p><table><thead><tr><th>Filename</th><th>Size</th><th>SHA224</th></tr></thead><tbody>' >> index.htm
ls -1 | while IFS= read -r file; do
	if [[ "$file" == *".htm" ]] ; then
		echo "Skipped file \"$file\"."
	else
		echo "<tr><td><a href=\"${file}\">${file}</a></td><td>$(stat --printf=%s ${file}) B</td><td>$(sha224sum $file | cut -d' ' -f1)</td></tr>" >> index.htm
	fi
done
echo '</tbody></table></body>' >> index.htm
exit