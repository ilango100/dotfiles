#!/bin/sh

# Build env
mkdir -p ~/build
cd ~/build

# Download latest source
latest=$(curl -l ftp://ftp.vim.org/pub/vim/unix/ | tail -n1)
curl -O http://ftp.vim.org/pub/vim/unix/$latest
tar -xf $latest
vimdir=$(echo ${latest%.tar.bz2} | tr -d '.-')
cd $vimdir

# Build and install vim
./configure \
	--without-x \
	--disable-gui \
	--disable-canberra \
	--disable-netbeans \
	--enable-multibyte \
	--enable-terminal \
	--enable-luainterp=dynamic \
	--with-luajit
make -j$(nproc)
sudo make install
