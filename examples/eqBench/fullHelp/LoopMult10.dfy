// MODEL

function fooM(a: int, b: int): int {
	fooMHelper(a, b, 0, 1)
}

function fooMHelper(a: int, b: int, c: int, i: int): int
	decreases b - i
{
	if i <= b then fooMHelper(a, b, c + a, i + 1)
	else c
}

function mainM(x: int): int {
	if (x>=9 && x < 12) then fooM(x,10)
	else 0
}

// CANDIDATE

function foo1(a: int, b: int): int {
	foo1Helper(a, b, 0, 1)
}

function foo1Helper(a: int, b: int, c: int, i: int): int
	decreases a - i
{
	if i <= a then foo1Helper(a, b, c + b, i + 1)
	else c
}

function main1(x: int): int {
	if (x>=9 && x < 12) then foo1(x,10)
	else 0
}

lemma equivalence(x: int)
	ensures mainM(x) == main1(x)
{
	assert fooM(9, 10) == foo1(9, 10);
	assert fooM(10, 10) == foo1(10, 10);
	assert fooM(11, 10) == foo1(11, 10);
}
