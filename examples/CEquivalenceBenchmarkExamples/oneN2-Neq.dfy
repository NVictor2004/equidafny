// oldV.dfy

method old_lib(x: int) returns (res: int){
	if (x > 10)
		return 11;
	else
		return x;
}
method old_client(x: int) returns (res: int){
	if (x > lib(x))
		return x;
	else
		return lib(x);
}
// newV.dfy

method new_lib(x: int) returns (res: int){
	if (x > 10)
		return 11;
	else
		return x+1;//change
}
method new_client(x: int) returns (res: int){
	if (x > lib(x))
		return x;
	else
		return lib(x);
}