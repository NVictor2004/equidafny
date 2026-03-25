// oldV.dfy

method old_snippet(a: double, b: double) returns (res: double) {
        if (b > a)
            return b;
        else
            return a;
}
// newV.dfy

method new_snippet(a: double, b: double) returns (res: double) {
        if (b < a)//change
            return a;//change
        else
            return b;//change
}