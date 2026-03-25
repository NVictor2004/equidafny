method snippet(a: double, b: double) returns (res: double) {
        if (b >= 0){
            a = -a;//change:inserted
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