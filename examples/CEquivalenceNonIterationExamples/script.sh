
# find . -type f -name "*.dfy" -exec bash script.sh {} \;
# find . -mindepth 2 -maxdepth 2 -type d -exec bash script.sh {} \;

# filename=$(basename "$1")
# filename="${filename%.*}"
# path=$(dirname "$1")

# sed -i -E '/int\s+[a-zA-Z0-9_]+\s*;$/d' $1

# perl -pi -e 's/bool (\w+)\s*\((.*?)\)/ "function $1(" . ($2 =~ s|(\w+)\s+(\w+)|$2: $1|gr) . "): bool" /ge' $1

# awk '
#   /\/\/ oldV.dfy/ { section="old"; print; next }
#   /\/\/ newV.dfy/ { section="new"; print; next }

#   section=="old" { 
#       if ($0 !~ /(if|printf|fabs|sqrt|exp|sin|cos)\(/) {
#         gsub(/([a-zA-Z0-9_]+)\(/, "old_&");
#       }
#       print
#   }

#   section=="new" { 
#       if ($0 !~ /(if|printf|fabs|sqrt|exp|sin|cos)\(/) {
#         gsub(/([a-zA-Z0-9_]+)\(/, "new_&");
#       }
#       print
#   }' $1 | sponge $1

sed -i '1i\\' $1
grep -q "sqrt(" $1 && sed -i '1i function sqrt(x: real): real' $1
grep -q "fabs(" $1 && sed -i '1i function fabs(x: real): real' $1
grep -q "exp(" $1 && sed -i '1i function exp(x: real): real' $1
grep -q "sin(" $1 && sed -i '1i function sin(x: real): real' $1
grep -q "cos(" $1 && sed -i '1i function cos(x: real): real' $1
grep -q "log(" $1 && sed -i '1i function log(x: real): real' $1
grep -q "tan(" $1 && sed -i '1i function tan(x: real): real' $1
grep -q "pow(" $1 && sed -i '1i function pow(x: real, y: real): real' $1

# sed -i -E 's/(\w+)\s*\/=\s*(.+);/\1 := \1 / \2;/' $1
# sed -i -E 's/method new_(\w+)\(/method \1(/' $1

# sed -i -E 's/function\s+(\w+)\s*\((.*?)\): (\w+)/method \1(\2) returns \(res: \3\)/' $1

# perl -0777 -pi -e 's/typedef struct (\w+) \{([\s\S]*?)\}\s*(\w+)\s*;/ "datatype $3 = $1(" . ($2 =~ s|(\w+)\s+(\w+);|$2: $1,|gmr) . ")" /ge' $1