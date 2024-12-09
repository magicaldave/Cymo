#!/usr/bin/env sh

PYCURL_URL="$1"
TARGET_TRIPLE="$2"

wget -O pycurl.zip $PYCURL_URL
mkdir -p dep/bin && unzip -j pycurl.zip "pycurl.libs/*" -d dep/bin/
python -m pip install pyoxidizer
pyoxidizer run --target install --release
mv build/$TARGET_TRIPLE/release/install/umo .
mv build/$TARGET_TRIPLE/release/install/lib dep/
