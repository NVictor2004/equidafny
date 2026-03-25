typedef struct newV {
    int x;
    long y;
    int z;
}ejhash;
ejhash constructor(int x, long y, int z) {
		ejhash obj;
	    obj.x = x;
	    obj.y = y;
	    obj.z = z;
		return obj;
}
method hashCode(ejhash obj) returns (res: int) {
    //var h: int := x;//change
    var h: int := obj.x * 31 + (int) (obj.y ^ (obj.y >> 32));//change
	h = h * 31 + obj.z;
	return h;
}