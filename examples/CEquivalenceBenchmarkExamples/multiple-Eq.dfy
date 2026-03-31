// oldV.dfy

method old_lib(x: int) returns (res: int) {
	return x % 5;
}
method old_client(x: int) returns (res: int){
	var x := x*5*6;
	if (old_lib(x)==0){
		return 1;
	}else{
		return 0;
	}
}
// newV.dfy

method new_lib(x: int) returns (res: int) {
	return x % 6;
}
method new_client(x: int) returns (res: int){
	var x := x*5*6;
	if (new_lib(x)==0){
		return 1;
	}else{
		return 0;
	}
}
