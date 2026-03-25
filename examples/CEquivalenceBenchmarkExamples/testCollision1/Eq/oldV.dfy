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
    int h = obj.x;
	h = h * 31 + (int) (obj.y ^ (obj.y >> 32));
	h = h * 31 + obj.z;
	return h;
}
function testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int): Unit {
	    ejhash o1 = constructor(x1, y1, z1);
	    ejhash o2 = constructor(x2, y2, z2);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}