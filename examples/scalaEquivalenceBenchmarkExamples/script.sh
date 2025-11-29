# find . -name "*.dfy" -exec bash script.sh {} \;

# grep -v "object" $1 > temp1.dfy
# mv temp1.dfy $1

# sed -i 's/: int =/ returns (res: int) {/g' $1

# sed -n "/method/H; /requires/{H; $!d}; /decreases/{H; $!d}; x; p" "./adjlist/AdjList.dfy"
# sed -n '/^method/{N;N;/^method.*\requires.*\ndecreases.*/p}' "./adjlist/AdjList.dfy"
# sed -n '/^method/{N; /requires\|decreases/{N; /requires\|decreases/{p}}}' "./adjlist/AdjList.dfy"

sed -i -f "stuff.sed" "$1"
