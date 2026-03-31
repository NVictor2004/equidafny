// oldV.dfy

datatype ejhash = old_oldV(
    x: int,
    y: long,
    z: int,
)
ejhash old_constructor(int x, long y, int z) {
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
method old_testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := old_constructor(x1, y1, z1);
	    var o2: ejhash := old_constructor(x2, y2, z2);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}
// newV.dfy

datatype ejhash = new_newV(
    x: int,
    y: long,
    z: int,
)
ejhash new_constructor(int x, long y, int z) {
		ejhash obj;
	    obj.var x := x;
	    obj.var y := y;
	    obj.var z := z;
		return obj;
}
method new_hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	var h := h * 31 + (int) (obj.y ^ (obj.y >> 32));
	var h := h * 31 + obj.z;
	return h;
}
method new_testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := new_constructor(x1, y1, z1);
	    var o2: ejhash := new_constructor(z2, y2, x2);//change
	    if (new_hashCode(o1) == new_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}
