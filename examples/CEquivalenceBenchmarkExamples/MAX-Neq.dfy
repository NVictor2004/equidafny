// oldV.dfy

method old_snippet(a: real, b: real) returns (res: real) {
        if (b > a)
            return b;
        else
            return a;
}
// newV.dfy

method new_snippet(a: real, b: real) returns (res: real) {
        if (b > a)
            return 0;//change
        else
            return a;
}
