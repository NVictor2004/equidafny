// oldV.dfy

method old_snippet(a: double) returns (res: double)
{
    return a*a;
}
// newV.dfy

method new_snippet(a: double) returns (res: double)
{
        var result: double := 0;//change
        var result := a*a;//change
        return result;//change
}