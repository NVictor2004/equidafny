method lib(x: int) returns (res: int){
	if (x > 10)
		return 11;
	else
		return x;
}
method client(x: int) returns (res: int){
	if (x > lib(x))
		return x;
	else
		return lib(x);
}