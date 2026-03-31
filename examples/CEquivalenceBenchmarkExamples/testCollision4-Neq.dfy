
// oldV.dfy

datatype ejhash = V(
    x: int,
    y: real,
    z: int
)

method old_constructor(x: int, y: real, z: int) returns (res: ejhash) {
		var obj: ejhash := V(x, y, z);
		return obj;
}
function old_hashCode(obj: ejhash): int {
    var h: int := obj.x;
	var h := h * 31 + ((obj.y as bv64 ^ (obj.y as bv64 >> 32)) as int);
	var h := h * 31 + obj.z;
	h
}
method old_testCollision4(x1: int, y1: real, z1: int) {
	    var o1: ejhash := old_constructor(1234, 6454505372016058754.0, 3141);
	    var o2: ejhash := old_constructor(x1, y1, z1);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        print("%s\n","Solved hash collision 4");
	    }
}
// newV.dfy

method new_constructor(x: int, y: real, z: int) returns (res: ejhash) {
		var obj: ejhash := V(x, y, z);
		return obj;
}
function new_hashCode(obj: ejhash): int {
    var h: int := obj.x;
	var h := h * 31 + ((obj.y as bv64 ^ (obj.y as bv64 >> 32)) as int);
	var h := h * 31 + obj.z;
	h
}
method new_testCollision4(x1: int, y1: real, z1: int) {
	    var o1: ejhash := new_constructor(1234, 6454505372016058754.0, 3141);
	    var o2: ejhash := new_constructor(x1, y1, z1);
	    if (new_hashCode(o1) == new_hashCode(o2) && y1 == (z1 as real)) {//change
	        print("%s\n","Solved hash collision 4");
	    }
}
