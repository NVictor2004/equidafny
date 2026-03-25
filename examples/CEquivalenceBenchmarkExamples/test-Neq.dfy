// oldV.dfy

method old_snippet(x: int, y: int) returns (res: real) {
        if (x*x*x > 0){
            if(x>0 && y==10)
                return 1000;
        } else {
            if (x>0 && y==20)
                return -1000;
        }
        return 0;
}
// newV.dfy

method new_snippet(x: int, y: int) returns (res: real) {
        if (x*x*x < 0){//change
            if(x>0 && y==10)
                return 1000;
        } else {
            if (x>0 && y==20)
                return -1000;
        }
        return 0;
}