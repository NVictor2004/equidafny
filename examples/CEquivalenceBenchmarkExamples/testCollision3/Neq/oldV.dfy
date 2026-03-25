datatype ejhash = oldV(
    x: int,
    y: long,
    z: int,
)
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
method testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := constructor(1234, y1, 3141);
	    var o2: ejhash := constructor(5678, y2, 3141);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 3");
	    }
}