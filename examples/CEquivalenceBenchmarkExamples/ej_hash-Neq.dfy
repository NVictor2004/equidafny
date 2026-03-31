
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
method hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	var h := h * 31 + (int) (obj.y ^ (obj.y >> 32));
	var h := h * 31 + obj.z;
	return h;
}
method testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := old_constructor(x1, y1, z1);
	    var o2: ejhash := old_constructor(x2, y2, z2);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}
method testCollision2(y1: long, z1: int,y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := old_constructor(1, y1, z1);
	    var o2: ejhash := old_constructor(2, y2, z2);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 2");
	    }
}
method testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := old_constructor(1234, y1, 3141);
	    var o2: ejhash := old_constructor(5678, y2, 3141);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 3");
	    }
}
method testCollision4(x1: int, y1: long, z1: int) returns (res: Unit) {
	    var o1: ejhash := old_constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := old_constructor(x1, y1, z1);
	    if (old_hashCode(o1) == old_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 4");
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
method hashCode(ejhash obj) returns (res: int) {
    var h: int := obj.x;
	var h := h * 31 + (int) (obj.y ^ (obj.y >> 32));
	//var h := h * 31 + obj.z;
	return h;
}
method testCollision1(x1: int, y1: long, z1: int,x2: int, y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := new_constructor(x1, y1, z1);
	    var o2: ejhash := new_constructor(z2, y2, x2);//change
	    if (new_hashCode(o1) == new_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 1");
	    }
}
method testCollision2(y1: long, z1: int,y2: long, z2: int) returns (res: Unit) {
	    var o1: ejhash := new_constructor(1, y1, z1);
	    var o2: ejhash := new_constructor(2, y2, z2);
	    if (new_hashCode(o1) == new_hashCode(o2)) {
	        printf("%s\n","Solved hash collision 2");
	    }
		else{//change
			printf("%s\n","Not equal");//change
		}
}
method testCollision3(y1: long, y2: long) returns (res: Unit) {
	    var o1: ejhash := new_constructor(5678, y1, 3141);//change
	    var o2: ejhash := new_constructor(5678, y2, 3141);
	    if (new_hashCode(o1) == new_hashCode(o2)) {
	        printf("%s\n","collision Occures");//change
	    }
}
method testCollision4(x1: int, y1: long, z1: int) returns (res: Unit) {
	    var o1: ejhash := new_constructor(1234, 6454505372016058754, 3141);
	    var o2: ejhash := new_constructor(x1, y1, z1);	
	    if (new_hashCode(o1) == new_hashCode(o2) && y1==z1) {//change
	        printf("%s\n","Solved hash collision 4");
	    }
}
