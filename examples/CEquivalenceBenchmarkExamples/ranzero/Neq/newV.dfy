method new_snippet(idum: int) returns (res: double) {//idum is a global variable
        var IA: int := 16807;
        var IM: int := 2147483647;
        var IQ: int := 127773;
        var IR: int := 2836;
        var MASK: int := 123459876;
        var AM: double := 1.0/(double)IM;
        var k: int := 0;
        var ans: double := 0.0;
        idum *= MASK;
        var k := idum/IQ;
        var idum := IA*(idum-k*IQ)-IR*k;
        if (idum < 0){
            idum += IM;
            idum *=IA;//change
        }
        var ans := AM*idum;
        idum *= MASK;
        return ans;
    }