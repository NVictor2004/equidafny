
types=$(find ./json/ -mindepth 1 -maxdepth 1 -type d ! -name "counterExamples")

classNames=("automatic" "helperequivalence" "auxiliarylemmas" "induction" "termination" "higherorder" "assumption" "candcopy" "matchflattening" "varinlining" "types")
nClasses=${#classNames[@]}

for type in $types; do
    echo "$type"
    counts=()
    for ((i=0; i<nClasses; i++)); do
        counts+=(0)
    done
    dirs=$(find $type -mindepth 1 -maxdepth 1 -type d)
    for dir in $dirs; do
        dirname=$(basename "$dir")
        dirname="${dirname,,}"
        nfiles=$(find $dir -type f | wc -l)
        while [[ "$dirname" != "" ]]; do
            for ((i=0; i<nClasses; i++)); do
                className="${classNames[i]}"
                if [[ "$dirname" =~ ^"$className"(.*) ]]; then
                    dirname="${BASH_REMATCH[1]}"
                    (( counts[i]+=$nfiles ))
                    continue 2
                fi
            done
            echo "The rest of $dirname could not be matched"
            break
        done
    done
    echo "${counts[@]}"
done