method snippet(x: int, y: int) returns (res: int) {
        var result: int := 0; 
        var path: int := 0;
        if (x > 0) {
            if (y == x * x) {
                path = 1;
            }
            else {
                path = 2;
            }
            if (-y < -8) {//change
                if (path == 1)
                    result = 3;
                if (path == 2)
                    result = 13;
            }
            else {
                if (path == 1)
                    result = 4;
                if (path == 2)
                    result = 14;
            }
        }
        return result;
    }