method lib(x: int) returns (res: int) {
	if (x < 0)
		return 0;
	else
		return x;
}
method client(x: int) returns (res: int){
	if (x < 0){
		return -lib((-x)*5)/5;
	}else{
		return lib((x+1)*5)/5 - 1;
	}
}