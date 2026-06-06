// MODEL

function fooM(a: int, b: int): int {
	var c: int := 0;
	if (a < 0) then
		for (var i: int := 1;i<=b;++i)
			c+=a;
	}
	c
}
function mainM(x: int, char*argv[]): int {
	if (x>=5 && x < 7)
		fooM(x,5)
	0
}

// CANDIDATE

function foo1(a: int, b: int): int {
	var c: int := 1;
	if (a < 0) then
		for (var i: int := 1;i<=a;++i)
			c+=b;
	}
	c
}
function main1(x: int, char*argv[]): int {
	if (x>=5 && x < 7)
		foo1(x,5)
	0
}