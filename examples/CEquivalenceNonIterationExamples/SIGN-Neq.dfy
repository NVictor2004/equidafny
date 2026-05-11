
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
        if (b >= 0){
            var a := -a;//change:inserted
            if (a >= 0)
                return a;
            else
                return 0;//change
        }
        else {
            if (a >= 0 && b>=0) //change: unsafisfiable condition
                return -a;
            else
                return a;
        }
}
