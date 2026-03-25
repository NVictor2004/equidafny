typedef struct oldV {
    int x;
    long y;
    int z;
}ejhash;
ejhash constructor(int x, long y, int z) {
		ejhash obj;
	    obj.var x := x;
	    obj.var y := y;
	    obj.var z := z;
		return obj;
}
method hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	var h := h * 31 + (int) (obj.y ^ (obj.y >> 32));
	var h := h * 31 + obj.z;
	return h;
}
method testCollision2(y1: long, z1: int,y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1, y1, z1);
	    var o2: ejhash := constructor(2, y2, z2);
	    if (hashCode(o1) == hashCode(o2)) {
			printf("%s\n","Solved hash collision 2");
	    }
}