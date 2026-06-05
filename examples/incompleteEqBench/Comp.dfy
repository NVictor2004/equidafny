// MODEL

function fooM(a: int, b: int): int {
	if (a > b) then 1 else 0
}
function mainM(): int {
	var x: int := 2;
	var y: int := 3;
	var z: int := fooM(x,y);
	if (z == 0) then
		var tmp: int := y;
		var y := x;
		var x := tmp;
		y
	else y
}

// CANDIDATE

function foo1(a: int, b: int): int {
	if (a < b) then 1 else 0
}
function main1(): int {
	var x: int := 2;
	var y: int := 3;
	var z: int := foo1(x, y);
	if (z != 0) then
		var tmp :int := y;
		var y := x;
		var x := tmp;
		y
	else y
}