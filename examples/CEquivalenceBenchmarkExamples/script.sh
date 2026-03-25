
# find . -type f -name "*.dfy" -exec bash script.sh {} \;

# filename=$(basename "$1")
# filename="${filename%.*}"
# path=$(dirname "$1")

# sed -i '/^function.*;$/d' $1

# perl -pi -e 's/bool (\w+)\s*\((.*?)\)/ "function $1(" . ($2 =~ s|(\w+)\s+(\w+)|$2: $1|gr) . "): bool" /ge' $1

sed -i -E 's/([a-zA-Z0-9_]+)\s*=\s*(.*);/var \1 := \2;/' $1