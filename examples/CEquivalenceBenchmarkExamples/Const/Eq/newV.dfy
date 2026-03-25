function foo(a: int, b: int): int {
	const int d=3;
	int c=b+a;
	return c+d;
}
function main(void): int {
	return foo(5,900);
}