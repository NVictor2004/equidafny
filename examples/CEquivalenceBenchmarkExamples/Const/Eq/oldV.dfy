function foo(a: int, b: int): int {
	var c: int := a+b;
	return c+3;
}
function main(void): int {
	return foo(5,900);
}