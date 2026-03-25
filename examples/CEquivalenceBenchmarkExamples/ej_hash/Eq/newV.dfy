typedef struct newV {
    int x;
    long y;
    int z;
}ejhash;
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
method testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(x1, y1, z1);
	    var o2: ejhash := constructor(x2, y2, z2);
	    if (hashCode(o1) == hashCode(o2)) {
            var x1 := x2;//change
	        printf("%s\n","Solved hash collision 1");
	    }
}
method checkCond(o1: ejhash, o2: ejhash) returns (res: bool){
	return hashCode(o1) == hashCode(o2);
}
method testCollision2(y1: long, z1: int,y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1, y1, z1);
	    var o2: ejhash := constructor(2, y2, z2);
	    if (checkCond(o1, o2)) {//change
			printf("%s\n","Solved hash collision 2");
	    }
}
method testCollision3(y1: long, y2: long) returns (res: Unit) {
		var z: int := 3141;//change
	    var o1: ejhash := constructor(1234, y1, z);//change
	    var o2: ejhash := constructor(5678, y2, z);//change
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 3");
	    }
}
method testCollision4(x1: int, y1: long, z1: int) returns (res: Unit) {
	    var o1: ejhash := constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := constructor(x1, y1, z1);
		var x1 := z1;//change		
	    if (hashCode(o1) == hashCode(o2)) {
	        printf("%s\n","Solved hash collision 4");
	    }
}