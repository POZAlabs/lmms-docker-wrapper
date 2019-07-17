
DISPLAY="" wine cmd /c

MONO_VERSION="4.9.0"
GECKO_VERSION="2.47"

for ARCH in x86 x86_64; do
curl -L "http://source.winehq.org/winemono.php?arch=$ARCH&v=$MONO_VERSION" -o "mono-$ARCH.msi"
curl -L "http://source.winehq.org/winegecko.php?arch=$ARCH&v=$GECKO_VERSION" -o "gecko-$ARCH.msi"
DISPLAY="" wine msiexec /i "mono-$ARCH.msi"
DISPLAY="" wine msiexec /i "gecko-$ARCH.msi"
rm "mono-$ARCH.msi" "gecko-$ARCH.msi"
done