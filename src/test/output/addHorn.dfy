function add_horn_1(i: int, j: int): int
requires (i >= 0)
{if (i == 0) then j else add_horn_1((i - 1), (j + 1))}

function add_horn_2(i: int, j: int): int
requires (i >= 0)
{if (i == 0) then j else if (i == 1) then (j + 1) else add_horn_2((i - 1), (j + 1))}

lemma add_horn_1_add_horn_2_Equivalence(i: int, j: int)
requires (i >= 0)
ensures (add_horn_1(i, j) == add_horn_2(i, j))
{{}}

