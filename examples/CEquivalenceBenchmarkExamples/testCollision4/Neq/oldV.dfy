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
method old_hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	var h := h * 31 + (int) (obj.y ^ (obj.y >> 32));
	var h := h * 31 + obj.z;
	return h;
}
method old_testCollision4(x1: int, y1: long, z1: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := constructor(x1, y1, z1);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 4");
	    }
}