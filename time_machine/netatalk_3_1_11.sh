#!/usr/bin/env bash

#Install Netatalk dependencies.
echo "Installing Netatalk 3.1.11 dependencies..."
echo "Please see http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.11_on_Ubuntu_16.04_Xenial"
echo ""
sudo apt-get install build-essential
sudo apt-get install libevent-dev
sudo apt-get install libssl-dev
sudo apt-get install libgcrypt-dev
sudo apt-get install libkrb5-dev
sudo apt-get install libpam0g-dev
sudo apt-get install libwrap0-dev
sudo apt-get install libdb-dev
sudo apt-get install libtdb-dev
sudo apt-get install libmysqlclient-dev
sudo apt-get install avahi-daemon
sudo apt-get install libavahi-client-dev
sudo apt-get install libacl1-dev
sudo apt-get install libldap2-dev
sudo apt-get install libcrack2-dev
sudo apt-get install systemtap-sdt-dev
sudo apt-get install libdbus-1-dev
sudo apt-get install libdbus-glib-1-dev
sudo apt-get install libglib2.0-dev
sudo apt-get install libio-socket-inet6-perl
sudo apt-get install tracker
sudo apt-get install libtracker-sparql-1.0-dev
sudo apt-get install libtracker-miner-1.0-dev
echo "Completed installing dependences"

#Download Netatalk.
echo "Downloading Netatalk 3.1.11..."
cd ~
curl https://phoenixnap.dl.sourceforge.net/project/netatalk/netatalk/3.1.11/netatalk-3.1.11.tar.gz > netatalk-3.1.11.tar.bz2
echo "Completed download"

#Extract the contents.
echo "Extracting contents..."
tar xvf netatalk-3.1.11.tar.bz2
echo "Extraction complete"

#Configure!
echo "Configuring..."
cd netatalk-3.1.11/
./configure \
        --with-init-style=debian-systemd \
        --without-libevent \
        --without-tdb \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-daemon=/usr/bin/dbus-daemon \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=1.0
echo "Configuration complete"

#Install!
echo "Installing..."
make
sudo make install
echo "Installation complete"

echo "Done!
