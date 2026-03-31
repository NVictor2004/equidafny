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
    //var h: int := x;//change
    var h: int := obj.x * 31 + (int) (obj.y ^ (obj.y >> 32));//change
	var h := h * 31 + obj.z;
	return h;
}
