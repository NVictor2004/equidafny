
// oldV.dfy

method old_snippet(a: real, b: real) returns (res: real) {
        if (b >= 0){
            if (a >= 0)
                return a;
            else
                return -a;
        }
        else {
            if (a >= 0)
                return -a;
            else
                return a;
        }
}
// newV.dfy

method new_snippet(a: real, b: real) returns (res: real) {
        if (a >= 0 && b >= 0)//change
            return a;
        if (a < 0 && b < 0)//change
            return a;
        else 
            return -a;//change    
}
