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

function mainM(): int {
	fooM(2,2)
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

function main1(): int {
	foo1(2,2)
}

lemma equivalence()
	ensures mainM() == main1()
{}
