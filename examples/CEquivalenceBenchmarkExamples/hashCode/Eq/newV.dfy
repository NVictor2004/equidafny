datatype ejhash = newV(
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
    //var h: int := x;//change
    var h: int := obj.x * 31 + (int) (obj.y ^ (obj.y >> 32));//change
	var h := h * 31 + obj.z;
	return h;
}