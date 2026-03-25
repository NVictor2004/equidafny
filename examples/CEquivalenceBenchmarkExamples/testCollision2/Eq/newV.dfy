
typedef struct newV {
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
function testCollision2(y1: long, z1: int,y2: long, z2: int): Unit {
	    var o1: ejhash := constructor(1, y1, z1);
	    var o2: ejhash := constructor(2, y2, z2);
	    if (checkCond(o1, o2)) {//change
			printf("%s\n","Solved hash collision 2");
	    }
}
function checkCond(o1: ejhash, o2: ejhash): bool{
	return hashCode(o1) == hashCode(o2);
}