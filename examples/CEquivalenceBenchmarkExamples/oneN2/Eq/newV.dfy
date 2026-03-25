function lib(x: int): int{
	if (x > 11)//change
		return 11;
	else
		return x-1;//change
}
function client(x: int): int{
	if (x > lib(x))
		return x;
	else
		return lib(x);
}