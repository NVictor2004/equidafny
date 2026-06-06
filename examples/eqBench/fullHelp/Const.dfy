// MODEL

function fooM(a: int, b: int): int {
	var c := a+b;
	c+3
}
function mainM(): int {
	fooM(5,900)
}

// CANDIDATE

function foo1(a: int, b: int): int {
	var d := 3;
	var c := b+a;
	c+d
}
function main1(): int {
	foo1(5,900)
}

lemma equivalence()
	ensures mainM() == main1()
{}
