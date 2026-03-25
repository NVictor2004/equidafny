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
    //int h = x;//change
    int h = obj.x * 31 + (int) (obj.y ^ (obj.y >> 32));//change
	h = h * 31 + obj.z;
	return h;
}
function testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int): Unit {
	    ejhash o1 = constructor(x1, y1, z1);
	    ejhash o2 = constructor(x2, y2, z2);
	    if (hashCode(o1) == hashCode(o2)) {
            x1=x2;//change
	        printf("%s\n","Solved hash collision 1");
	    }
}
function checkCond(o1: ejhash, o2: ejhash): bool{
	return hashCode(o1) == hashCode(o2);
}
function testCollision2(y1: long, z1: int,y2: long, z2: int): Unit {
	    ejhash o1 = constructor(1, y1, z1);
	    ejhash o2 = constructor(2, y2, z2);
	    if (checkCond(o1, o2)) {//change
			printf("%s\n","Solved hash collision 2");
	    }
}
function testCollision3(y1: long, y2: long): Unit {
		int z = 3141;//change
	    ejhash o1 = constructor(1234, y1, z);//change
	    ejhash o2 = constructor(5678, y2, z);//change
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 3");
	    }
}
function testCollision4(x1: int, y1: long, z1: int): Unit {
	    ejhash o1 = constructor(1234, 6454505372016058754, 3141);
	    ejhash o2 = constructor(x1, y1, z1);
		x1=z1;//change		
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 4");
	    }
}