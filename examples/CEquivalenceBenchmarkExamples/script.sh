
# find . -type f -name "*.dfy" -exec bash script.sh {} \;

# filename=$(basename "$1")
# filename="${filename%.*}"
# path=$(dirname "$1")

sed -i '/^#include/d' $1
