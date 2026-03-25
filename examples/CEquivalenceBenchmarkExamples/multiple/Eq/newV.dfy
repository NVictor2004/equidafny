method lib(x: int) returns (res: int) {
	return x % 6;
}
method client(x: int) returns (res: int){
	var x := x*5*6;
	if (lib(x)==0){
		return 1;
	}else{
		return 0;
	}
}