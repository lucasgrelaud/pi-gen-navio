#!/bin/bash -ex

# Clone the wifibroadcast repository
cd ~/
if [[ -d "wifibroadcast" ]]; then
    rm -rf "wifibroadcast"
fi
git clone https://github.com/svpcom/wifibroadcast.git
cd ~/wifibroadcast

# Build wifibroadcast
make deb

# Install the deb
cd ~/wifibroadcast/deb_dist
dpkg -i wifibroadcast*.deb