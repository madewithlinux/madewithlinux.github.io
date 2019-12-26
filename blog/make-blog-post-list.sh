#!/bin/bash
set -exo pipefail

INFILE="$1"
DEST="./index.html"
DEST_NEW="${DEST}.new"

echo -n > "${DEST_NEW}"
cat list-header.html >> "${DEST_NEW}"

for post_index in $@; do
    post_folder="$(dirname ${post_index})"
    if [[ -e "${post_folder}/exclude-from-index" ]]; then
        continue
    fi
    post_url="/blog/${post_folder}/"
    post_title="$(head -n1 ${post_folder}/body.html | tr -d '\n')"

    echo '<a href="'"${post_url}"'">' >> "${DEST_NEW}"
    echo '<h2>' >> "${DEST_NEW}"
    echo "${post_title}" >> "${DEST_NEW}"
    echo '</h2>' >> "${DEST_NEW}"
    echo '</a>' >> "${DEST_NEW}"
    echo >> "${DEST_NEW}"
done

cat list-footer.html >> "${DEST_NEW}"

mv "${DEST_NEW}" "${DEST}"
