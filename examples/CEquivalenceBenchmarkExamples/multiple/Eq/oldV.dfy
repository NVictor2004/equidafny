function lib(x: int): int {
	return x % 5;
}
function client(x: int): int{
	x = x*5*6;
	if (lib(x)==0){
		return 1;
	}else{
		return 0;
	}
}