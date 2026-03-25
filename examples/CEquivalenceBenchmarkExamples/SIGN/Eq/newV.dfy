method new_snippet(a: double, b: double) returns (res: double) {
        if (a >= 0 && b >= 0)//change
            return a;
        if (a < 0 && b < 0)//change
            return a;
        else 
            return -a;//change    
}
