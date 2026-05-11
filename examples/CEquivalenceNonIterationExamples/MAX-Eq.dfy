
// oldV.dfy

method old_snippet(a: real, b: real) returns (res: real) {
        if (b > a)
            return b;
        else
            return a;
}
// newV.dfy

method new_snippet(a: real, b: real) returns (res: real) {
        if (b < a)//change
            return a;//change
        else
            return b;//change
}
