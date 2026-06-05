// MODEL

function libM(x: int): int {
	if (x < 5) then
		5
	else
		x
}
function clientM(x: int): int {
	if (x < 0) then
		-libM((-x)*5)/5
	else
		libM((x+1)*5)/5 - 1
}

// CANDIDATE

function lib1(x: int): int {
	if (x < 0) then
		0
	else
		x
}
function client1(x: int): int {
	if (x < 0) then
		-lib1((-x)*5)/5
	else
		lib1((x+1)*5)/5 - 1
}