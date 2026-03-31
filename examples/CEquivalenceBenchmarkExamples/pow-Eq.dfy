// oldV.dfy

method old_snippet(x: int, y: int) returns (res: int) {
        var result: int := 0; 
        var path: int := 0;
        if (x > 0) {
            if (y == x * x) {
                var path := 1;
            }
            else {
                var path := 2;
            }
            if (y > 8) {
                if (path == 1)
                    var result := 3;
                if (path == 2)
                    var result := 13;
            }
            else {
                if (path == 1)
                    var result := 4;
                if (path == 2)
                    var result := 14;
            }
        }
        return result;
    }
// newV.dfy

method new_snippet(x: int, y: int) returns (res: int) {
        var result: int := 0; 
        var path: int := 0;
        if (x > 0) {
            if (y == x * x) {
                var path := 1;
            }
            else {
                var path := 2;
            }
            if (-y < -8) {//change
                if (path == 1)
                    var result := 3;
                if (path == 2)
                    var result := 13;
            }
            else {
                if (path == 1)
                    var result := 4;
                if (path == 2)
                    var result := 14;
            }
        }
        return result;
    }
