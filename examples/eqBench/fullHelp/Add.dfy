// MODEL

function fooM(a: int, b: int): int {
	a+b
}

function mainM(): int {
	fooM(5,900)
}

// CANDIDATE

function foo1(a: int, b: int): int {
	b+a
}
function main1(): int {
	foo1(5,900)
}

lemma equivalence()
	ensures mainM() == main1()
{}
