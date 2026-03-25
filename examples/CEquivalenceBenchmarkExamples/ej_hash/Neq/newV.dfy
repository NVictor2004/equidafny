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
method hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	h = h * 31 + (int) (obj.y ^ (obj.y >> 32));
	//h = h * 31 + obj.z;
	return h;
}
method testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(x1, y1, z1);
	    var o2: ejhash := constructor(z2, y2, x2);//change
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}
method testCollision2(y1: long, z1: int,y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1, y1, z1);
	    var o2: ejhash := constructor(2, y2, z2);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 2");
	    }
		else{//change
			printf("%s\n","Not equal");//change
		}
}
method testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := constructor(5678, y1, 3141);//change
	    var o2: ejhash := constructor(5678, y2, 3141);
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","collision Occures");//change
	    }
}
method testCollision4(x1: int, y1: long, z1: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := constructor(x1, y1, z1);	
	    if (hashCode(o1) == hashCode(o2) && y1==z1) {//change
	        printf("%s\n","Solved hash collision 4");
	    }
}