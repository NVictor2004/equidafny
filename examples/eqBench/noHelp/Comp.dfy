// MODEL

function fooM(a: int, b: int): int {
	if (a > b) then 1 else 0
}
function mainM(): int {
	var x := 2;
	var y := 3;
	var z := fooM(x,y);
	if (z == 0) then
		var tmp := y;
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
	var x := 2;
	var y := 3;
	var z := foo1(x, y);
	if (z != 0) then
		var tmp := y;
		var y := x;
		var x := tmp;
		y
	else y
}
