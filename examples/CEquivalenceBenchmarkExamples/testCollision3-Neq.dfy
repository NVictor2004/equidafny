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
method old_testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := old_constructor(1234, y1, 3141);
	    var o2: ejhash := old_constructor(5678, y2, 3141);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 3");
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
method new_testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := new_constructor(5678, y1, 3141);//change
	    var o2: ejhash := new_constructor(5678, y2, 3141);
	    if (new_hashCode(o1) == new_hashCode(o2)) {
	        printf("%s\n","collision Occures");//change
	    }
}
