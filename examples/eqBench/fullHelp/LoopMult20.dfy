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
	if (x>=18 && x < 22) then fooM(x,20)
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
	if (x>=18 && x < 22) then foo1(x,20)
	else 0
}

lemma equivalence(x: int)
	ensures mainM(x) == main1(x)
{
	assert fooM(18, 20) == fooMHelper(18, 20, 18 * 13, 14) == 18 * 20;
	assert foo1(18, 20) == foo1Helper(18, 20, 20 * 13, 14) == 18 * 20;

	assert fooM(19, 20) == fooMHelper(19, 20, 19 * 14, 15) == 19 * 20;
	assert foo1(19, 20) == foo1Helper(19, 20, 20 * 14, 15) == 19 * 20;

	assert fooM(20, 20) == fooMHelper(20, 20, 20 * 14, 15) == 20 * 20;
	assert foo1(20, 20) == foo1Helper(20, 20, 20 * 14, 15) == 20 * 20;

	assert fooM(21, 20) == fooMHelper(21, 20, 21 * 13, 14) == 21 * 20;
	assert foo1(21, 20) == foo1Helper(21, 20, 20 * 14, 15) == 21 * 20;
}
