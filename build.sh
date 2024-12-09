#!/usr/bin/env sh

set -euo

PYCURL_URL="${1:-https://files.pythonhosted.org/packages/64/d2/a4c45953aed86f5a0c9717421dd725ec61acecd63777dd71dfe3d50d3e16/pycurl-7.45.3-cp310-cp310-manylinux_2_28_x86_64.whl}"
TARGET_TRIPLE="${2:-x86_64-unknown-linux-gnu}"
TARGET_OS="${3:-linux}"

rm -rf dep build
mkdir -p oxcache

wget -O pycurl.zip $PYCURL_URL
mkdir -p dep/bin

echo $TARGET_OS

if [ "$TARGET_OS" = "Linux" ]; then
    unzip -j pycurl.zip "pycurl.libs/*" -d dep/bin/
else
    unzip -j pycurl.zip "pycurl-7.45.3.data/platlib/*" -d dep/bin/
fi

if [ -n "${USE_VENV+x}" ]; then
    python -m venv .venv
    source .venv/bin/activate
fi

python -m pip install pyoxidizer

PYOXIDIZER_CACHE_DIR="$(pwd)/oxcache" \
    pyoxidizer build exe install --release

mv build/$TARGET_TRIPLE/release/install/umo ./umo-$TARGET_TRIPLE
mv build/$TARGET_TRIPLE/release/install/lib dep/
