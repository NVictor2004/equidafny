method old_lib(x: int) returns (res: int) {
	if (x < 5)
		return 5;
	else
		return x;
}
method old_client(x: int) returns (res: int){
	if (x < 0){
		return -lib((-x)*5)/5;
	}else{
		return lib((x+1)*5)/5 - 1;
	}
}