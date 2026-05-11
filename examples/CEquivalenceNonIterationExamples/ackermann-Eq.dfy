
// oldV.dfy

method old_f(m: int, n: int) returns (res: int) {
    var x := 0;
    var r := 0;
    if (m == 0) {
        var r := n + 1;
    } else {
        if (m > 0 && n == 0) {
            var r := old_f(m - 1, 1);
        } else {
            var x := old_f(m, n - 1);
            var r := old_f(m - 1, x);
        }
    }
    return r;
}

// newV.dfy

method new_f(m: int, n: int) returns (res: int) {
    var x := 0;
    var r := 0;
    if (m > 0 && n == 0) {
        var r := new_f(m - 1, 1);
    } else {
        if (m == 0) {
            var r := n + 1;
        } else {
            var x := new_f(m, n - 1);
            var r := new_f(m - 1, x);
        }
    }
    return r;
}
