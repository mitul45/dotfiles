echo "Installing ag..."
sudo yum -y install pkgconfig automake gcc zlib-devel pcre-devel xz-devel
cd ~/git
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
sudo ./build.sh
sudo make install
