// MODEL

function fooM(a: int, b: int): int {
	var c: int := a-b;
	c
}
function mainM(): int {
	fooM(5,900)
}

// CANDIDATE

function foo1(a: int, b: int): int {
	var c: int := b-a;
	c
}
function main1(): int {
	foo1(900,5)
}