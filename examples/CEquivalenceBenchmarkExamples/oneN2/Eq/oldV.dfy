function lib(x: int): int{
	if (x > 10)
		return 11;
	else
		return x;
}
function client(x: int): int{
	if (x > lib(x))
		return x;
	else
		return lib(x);
}