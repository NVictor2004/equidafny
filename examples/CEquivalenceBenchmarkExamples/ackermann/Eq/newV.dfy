method new_f(m: int, n: int) returns (res: int) {
    var x := 0;
    var r := 0;
    if (m > 0 && n == 0) {
        var r := f(m - 1, 1);
    } else {
        if (m == 0) {
            var r := n + 1;
        } else {
            var x := f(m, n - 1);
            var r := f(m - 1, x);
        }
    }
    return r;
}
