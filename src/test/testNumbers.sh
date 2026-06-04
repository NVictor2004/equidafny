classNames=("automatic" "helperequivalence" "auxiliarylemmas" "induction" "termination" "higherorder" "types" "assumption" "candcopy" "matchflattening" "varinlining")
nClasses=${#classNames[@]}

copyDecreasesExclude=("terminationAuxiliaryLemmas" "terminationAuxiliaryLemmasInduction" "terminationHelperEquivalenceCandcopy")
eqBenchExclude=("auxiliaryLemmas" "auxiliaryLemmasAssumption" "auxiliaryLemmasAssumptionTermination" "terminationAuxiliaryLemmas" "terminationAuxiliaryLemmasInduction" "terminationHelperEquivalenceAuxiliaryLemmas" "assumption" "helperEquivalenceVarinlining")
selfWrittenExclude=("helperEquivalenceTerminationVarinlining" "terminationInductionAssumption" "typesInductionAuxiliaryLemmas" "terminationAuxiliaryLemmasTypesInductionCandcopy" "terminationCandcopy")
stainlessExclude=("auxiliaryLemmasVarinlining" "terminationAuxiliaryLemmas" "terminationAuxiliaryLemmasCandcopy" "terminationCandcopyMatchflattening" "terminationCandcopyInduction" "terminationHelperEquivalenceInductionCandcopyVarinlining" "terminationInductionAssumption")

countType() {
    local type="$1"
    shift
    local -a excludeDirs=("$@")

    echo "$type"
    counts=()
    for ((i=0; i<nClasses; i++)); do
        counts+=(0)
    done
    dirs=$(find $type -mindepth 1 -maxdepth 1 -type d)
    for dir in $dirs; do
        dirname=$(basename "$dir")
        for excludeDir in "${excludeDirs[@]}"; do
            if [[ "$dirname" == "$excludeDir" ]]; then
                continue 2
            fi
        done

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
}

countType "./json/copyDecreases" "${copyDecreasesExclude[@]}"
countType "./json/eqBench" "${eqBenchExclude[@]}"
countType "./json/selfWritten" "${selfWrittenExclude[@]}"
countType "./json/stainless" "${stainlessExclude[@]}"