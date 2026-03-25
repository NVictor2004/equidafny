typedef struct newV {
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
method testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(x1, y1, z1);
	    var o2: ejhash := constructor(z2, y2, x2);//change
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}