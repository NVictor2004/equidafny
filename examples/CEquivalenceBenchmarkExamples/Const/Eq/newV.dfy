function foo(a: int, b: int): int {
	const var d: int := 3;
	var c: int := b+a;
	return c+d;
}
function main(void): int {
	return foo(5,900);
}