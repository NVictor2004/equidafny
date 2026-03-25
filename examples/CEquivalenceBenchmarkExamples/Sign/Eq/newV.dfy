function snippet(a: double, b: double): double {
        if ((a >= 0 && b >= 0) || (a < 0 && b < 0))//change
            return a;
        else 
            return -a;//change    
}