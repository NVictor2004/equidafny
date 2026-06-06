// MODEL

function libM(x: int): int {
	x % 5
}

function clientM(x: int): int {
	var x := x*5*6;
	if (libM(x)==0) then
		1
	else
		0
}

// CANDIDATE

function lib1(x: int): int {
	x % 6
}

function client1(x: int): int {
	var x := x*5*6;
	if (lib1(x)==0) then
		1
	else
		0
}

lemma equivalence(x: int)
	ensures clientM(x) == client1(x)
{}
