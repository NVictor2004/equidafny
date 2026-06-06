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
	if (x>=13 && x < 16) then fooM(x,15)
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
	if (x>=13 && x < 16) then foo1(x,15)
	else 0
}

lemma equivalence(x: int)
	ensures mainM(x) == main1(x)
{
	assert fooM(13, 15) == fooMHelper(13, 15, 15 * 13, 16) == 13 * 15;
	assert foo1(13, 15) == 13 * 15;

	assert fooM(14, 15) == fooMHelper(14, 15, 14 * 14, 15) == 14 * 15;
	assert foo1(14, 15) == 14 * 15;

	assert fooM(15, 15) == fooMHelper(15, 15, 15 * 15, 16) == 15 * 15;
	assert foo1(15, 15) == foo1Helper(15, 15, 15 * 15, 16) == 15 * 15;
}
