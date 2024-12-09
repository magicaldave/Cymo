#!/usr/bin/env sh

set -euo

PYCURL_URL="${1:-https://files.pythonhosted.org/packages/64/d2/a4c45953aed86f5a0c9717421dd725ec61acecd63777dd71dfe3d50d3e16/pycurl-7.45.3-cp310-cp310-manylinux_2_28_x86_64.whl}"
TARGET_TRIPLE="${2:-x86_64-unknown-linux-gnu}"

rm -rf dep build
mkdir -p oxcache

wget -O pycurl.zip $PYCURL_URL
mkdir -p dep/bin && unzip -j pycurl.zip "pycurl.libs/*" -d dep/bin/

python -m venv .venv
source .venv/bin/activate
python -m pip install pyoxidizer

PYOXIDIZER_CACHE_DIR="$(pwd)/oxcache" \
    pyoxidizer build exe install --release

mv build/$TARGET_TRIPLE/release/install/umo ./umo-$TARGET_TRIPLE
mv build/$TARGET_TRIPLE/release/install/lib dep/
