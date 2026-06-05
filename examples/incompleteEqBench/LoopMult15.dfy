// MODEL

function fooM(a: int, b: int): int {
	var c: int := 0;
	for (var i: int := 1;i<=b;++i)
		c+=a;
	c
}
function mainM(x: int, char*argv[]): int {
	if (x>=13 && x < 16)
		fooM(x,15)
	0
}

// CANDIDATE

function foo1(a: int, b: int): int {
	var c: int := 0;
	for (var i: int := 1;i<=a;++i)
		c+=b;
	c
}
function main1(x: int, char*argv[]): int {
	if (x>=13 && x < 16)
		foo1(x,15)
	0
}