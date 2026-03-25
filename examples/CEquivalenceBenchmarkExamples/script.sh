
# find . -type f -name "*.dfy" -exec bash script.sh {} \;
# find . -mindepth 2 -maxdepth 2 -type d -exec bash script.sh {} \;

# filename=$(basename "$1")
# filename="${filename%.*}"
# path=$(dirname "$1")

# sed -i -E '/int\s+[a-zA-Z0-9_]+\s*;$/d' $1

# perl -pi -e 's/bool (\w+)\s*\((.*?)\)/ "function $1(" . ($2 =~ s|(\w+)\s+(\w+)|$2: $1|gr) . "): bool" /ge' $1

# sed -i -E 's/([a-zA-Z0-9_]+)\s*=\s*(.*);/var \1 := \2;/' $1

# sed -i -E 's/function\s+(\w+)\s*\((.*?)\): (\w+)/method \1(\2) returns \(res: \3\)/' $1

# perl -0777 -pi -e 's/typedef struct (\w+) \{([\s\S]*?)\}\s*(\w+)\s*;/ "datatype $3 = $1(" . ($2 =~ s|(\w+)\s+(\w+);|$2: $1,|gmr) . ")" /ge' $1

EqOrNeq=$(filename "$1")
dir=$(dirname "$1")
testType=$(basename "$dir")

concatFile="$1/$testType_$EqOrNeq.dfy"

echo "// oldV.dfy \n" > $concatFile
cat "$1/oldV.dfy" >> $concatFile
echo "\n\n// newV.dfy \n" >> $concatFile
cat "$1/newV.dfy" >> $concatFile