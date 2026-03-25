typedef struct oldV {
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
function hashCode(ejhash obj): int {
    var h: int := obj.x;
	h = h * 31 + (int) (obj.y ^ (obj.y >> 32));
	h = h * 31 + obj.z;
	return h;
}
function testCollision4(x1: int, y1: long, z1: int): Unit {
	    var o1: ejhash := constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := constructor(x1, y1, z1);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 4");
	    }
}