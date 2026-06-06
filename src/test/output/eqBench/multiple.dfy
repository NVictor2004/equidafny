function clientM(x: int): int
{var x := ((x * 5) * 6);
if (libM(x) == 0) then 1 else 0}

function client1(x: int): int
{var x := ((x * 5) * 6);
if (lib1(x) == 0) then 1 else 0}

function lib1(x: int): int
{(x % 6)}

function libM(x: int): int
{(x % 5)}

lemma clientM_client1_Equivalence(x: int)
ensures (clientM(x) == client1(x))
{{var x := ((x * 5) * 6);libM_lib1_Equivalence(x);}}

lemma libM_lib1_Equivalence(x: int)
ensures (libM(x) == lib1(x))
{{}}

