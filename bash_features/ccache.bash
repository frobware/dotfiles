: ${CCACHE_DIR:="/home/$USER/.ccache"}
export CCACHE_DIR
export CC="ccache gcc"
export CXX="ccache g++"
export PATH="/usr/lib/ccache:$PATH"

provide ccache
