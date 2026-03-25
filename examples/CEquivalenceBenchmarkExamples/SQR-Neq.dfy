// oldV.dfy

method old_snippet(a: real) returns (res: real)
{
    return a*a;
}
// newV.dfy

method new_snippet(a: real) returns (res: real)
{
    return a*a + 1;//change
}