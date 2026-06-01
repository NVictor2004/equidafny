
filename=$(basename "$1" ".scala")

sed -i '$a\}' "$1"