#!/bin/bash
set -e
release=$1
deploy=pi-gen/deploy
# Fix up filenames to match previous versions
mv "$deploy/image_$release.zip" "$deploy/$release-lite.zip"
mv "$deploy/image_$release-full.zip" "$deploy/$release-full.zip"
mv "$deploy/$release.info" "$deploy/$release-lite.info"
# Calculate hashes and upload
for suffix in "-lite" "-full"
do
    sha256sum "$deploy/$release-$suffix.zip" > "$deploy/$release-$suffix.zip.sha256"
    scp "$deploy/$release-$suffix.zip" build.openflexure.org:/var/www/build/raspbian-openflexure/
    scp "$deploy/$release-$suffix.info" build.openflexure.org:/var/www/build/raspbian-openflexure/
    scp "$deploy/$release-$suffix.zip.sha256" build.openflexure.org:/var/www/build/raspbian-openflexure/
done
echo "Copied release to build.openflexure.org, run:"
echo "    ssh build.openflexure.org -c "/var/www/build/update-latest.py"
echo "Then reload nginx config."
