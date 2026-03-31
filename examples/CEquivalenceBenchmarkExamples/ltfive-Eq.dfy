// oldV.dfy

method old_lib(x: int) returns (res: int) {
	if (x < 5)
		return 5;
	else
		return x;
}
method old_client(x: int) returns (res: int){
	if (x < 0){
		return -old_lib((-x)*5)/5;
	}else{
		return old_lib((x+1)*5)/5 - 1;
	}
}
// newV.dfy

method new_lib(x: int) returns (res: int) {
	if (x < 0)
		return 0;
	else
		return x;
}
method new_client(x: int) returns (res: int){
	if (x < 0){
		return -new_lib((-x)*5)/5;
	}else{
		return new_lib((x+1)*5)/5 - 1;
	}
}
