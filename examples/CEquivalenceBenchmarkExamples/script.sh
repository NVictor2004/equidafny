
filename=$(basename "$1")
filename="${filename%.*}"
path=$(dirname "$1")
mv "$1" "$path/$filename.dfy"
