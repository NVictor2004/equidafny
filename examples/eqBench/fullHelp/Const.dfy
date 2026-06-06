// MODEL

function fooM(a: int, b: int): int {
	var c: int := a+b;
	c+3
}
function mainM(): int {
	fooM(5,900)
}

// CANDIDATE

function foo1(a: int, b: int): int {
	var d: int := 3;
	var c: int := b+a;
	c+d
}
function main1(): int {
	foo1(5,900)
}

lemma equivalence()
	ensures mainM() == main1()
{}
