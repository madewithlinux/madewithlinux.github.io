#!/bin/bash
set -exo pipefail

INFILE="$1"
FOLDER="$(dirname ${INFILE})"
TITLE="$(head -n1 ${INFILE} | tr -d '\n')"
DEST="${FOLDER}/index.html"
DEST_NEW="${DEST}.new"

echo -n > "${DEST_NEW}"
cat post-header.html |sed "s/TITLE_HERE/${TITLE}/g" >> "${DEST_NEW}"
tail --lines=+2 "${FOLDER}/body.html" >> "${DEST_NEW}"
cat post-footer.html >> "${DEST_NEW}"

python3 ./html_postprocess.py "${DEST_NEW}"
mv "${DEST_NEW}" "${DEST}"
