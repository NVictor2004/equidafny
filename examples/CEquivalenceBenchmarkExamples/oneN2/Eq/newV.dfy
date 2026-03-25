method new_lib(x: int) returns (res: int){
	if (x > 11)//change
		return 11;
	else
		return x-1;//change
}
method new_client(x: int) returns (res: int){
	if (x > lib(x))
		return x;
	else
		return lib(x);
}