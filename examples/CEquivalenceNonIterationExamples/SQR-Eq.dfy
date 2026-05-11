
// oldV.dfy

method old_snippet(a: real) returns (res: real)
{
    return a*a;
}
// newV.dfy

method new_snippet(a: real) returns (res: real)
{
        var result: real := 0;//change
        var result := a*a;//change
        return result;//change
}
