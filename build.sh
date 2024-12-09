#!/usr/bin/env sh

set -euo

PYCURL_URL="${1:-https://files.pythonhosted.org/packages/64/d2/a4c45953aed86f5a0c9717421dd725ec61acecd63777dd71dfe3d50d3e16/pycurl-7.45.3-cp310-cp310-manylinux_2_28_x86_64.whl}"
TARGET_TRIPLE="${2:-x86_64-unknown-linux-gnu}"
TARGET_OS="${3:-Linux}"
UMO_IN="umo"
UMO_OUT="${UMO_IN}-${TARGET_TRIPLE}"

rm -rf build
mkdir -p oxcache

if [ "$TARGET_OS" = "Linux" ]; then
    rm -rf *.so
    wget -O pycurl.zip $PYCURL_URL
    unzip -j pycurl.zip "pycurl.libs/*" -d .
    ls -R .
else
    rm -rf *.dll
    UMO_IN="${UMO_IN}.exe"
    UMO_OUT="${UMO_OUT}.exe"
    echo $TARGET_OS $UMO_IN $UMO_OUT
    powershell -Command "Invoke-WebRequest -Uri $PYCURL_URL -OutFile pycurl.zip"
    unzip -j pycurl.zip "pycurl-7.45.3.data/platlib/*" -d .
fi

if [ -n "${USE_VENV+x}" ]; then
    python -m venv .venv
    source .venv/bin/activate
fi

python -m pip install pyoxidizer

PYOXIDIZER_CACHE_DIR="$(pwd)/oxcache" \
    pyoxidizer build exe install --release

mv build/$TARGET_TRIPLE/release/install/${UMO_IN} ./${UMO_OUT}
mv build/$TARGET_TRIPLE/release/install/lib .

if [ "$TARGET_OS" != "Linux" ]; then
    mv build/$TARGET_TRIPLE/release/install/*.dll .
fi
