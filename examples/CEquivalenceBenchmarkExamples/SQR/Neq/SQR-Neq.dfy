// oldV.dfy

method old_snippet(a: double) returns (res: double)
{
    return a*a;
}
// newV.dfy

method new_snippet(a: double) returns (res: double)
{
    return a*a + 1;//change
}