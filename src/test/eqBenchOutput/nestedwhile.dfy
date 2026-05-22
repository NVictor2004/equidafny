function fM(x: int, g: int): int
{f_outerM(x, g, 0)}

function f1(x: int, g: int): int
{f_outer1(x, g, 0)}

function f_inner1(x: int, g: int, i: int): (int, int)
decreases ((i - x))
{if (x < i) then f_inner1((x + 1), (g + 1), i) else (x, g)}

function f_outer1(x: int, g: int, i: int): int
decreases ((x - i))
{if (i < x) then var i_next := (i + 1);
var g_next := (g - 1);
var inner_res := f_inner1(x, g_next, i_next);
f_outer1(inner_res.0, inner_res.1, i_next) else g}

function f_innerM(x: int, g: int, i: int): (int, int)
decreases ((i - x))
{if (x < i) then var next_x := (x + 2);
var next_x := (next_x - 1);
f_innerM(next_x, (g + 1), i) else (x, g)}

function f_outerM(x: int, g: int, i: int): int
decreases ((x - i))
{if (i < x) then var next_i := (i + 1);
var next_g := (g - 2);
var next_g := (next_g + 1);
var inner_res := f_innerM(x, next_g, next_i);
f_outerM(inner_res.0, inner_res.1, next_i) else g}

lemma fM_f1_Equivalence(x: int, g: int)
ensures (fM(x, g) == f1(x, g))
{{f_outerM_f_outer1_Equivalence(x, g, 0);}}

lemma f_outerM_f_outer1_Equivalence(x: int, g: int, i: int)
decreases ((x - i))
ensures (f_outerM(x, g, i) == f_outer1(x, g, i))
{{match (i < x) {
case false =>
case true =>var next_i := (i + 1);var next_g := (g - 2);var next_g := (next_g + 1);var inner_res := f_innerM(x, next_g, next_i);f_outerM_f_outer1_Equivalence(inner_res.0, inner_res.1, next_i);
}
}}

