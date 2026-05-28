function oddM(x: int): int
{if (libM(x) == 0) then 1 else 0}

function odd1(x: int): int
requires (x > 0)
{if (lib1(x) == 0) then 1 else 0}

function lib1(x: int): int
requires (x > 0)
{if ((x % 2) == 0) then (1 + lib1((x / 2))) else 0}

function libM(x: int): int
{((x + 1) % 2)}

lemma oddM_odd1_Equivalence(x: int)
ensures (oddM(x) == odd1(x))
{{libM_lib1_Equivalence(x);}}

lemma libM_lib1_Equivalence(x: int)
ensures (libM(x) == lib1(x))
{{}}

