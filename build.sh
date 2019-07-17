cd /tmp
git clone --recurse-submodules https://github.com/POZAlabs/lmms -b testing
mkdir build && cd build

cmake ../lmms
# cmake .. -DLMMS_MINIMAL=ON -DPLUGIN_LIST="MidiImport;sf2_player;vst_base;vestige;VstEffect" # select plugins to build
make -j4
make install -j4 # Defaults to /usr/local, can be changed by passing -DCMAKE_INSTALL_PREFIX=<prefix> to CMake
