// MODEL

function fM(m: int, n: int): int
    requires m >= 0 && n >= 0
    ensures fM(m, n) >= 0
    decreases m, n
{
    if (m == 0) then
        n + 1
    else
        if (m > 0 && n == 0) then
            fM(m - 1, 1)
        else
            var x := fM(m, n - 1);
            fM(m - 1, x)
}


// CANDIDATE

function f1(m: int, n: int): int
    requires m >= 0 && n >= 0
    ensures f1(m, n) >= 0
    decreases m, n
{
    if (m > 0 && n == 0) then
        f1(m - 1, 1)
    else
        if (m == 0) then
            n + 1
        else
            var x := f1(m, n - 1);
            f1(m - 1, x)
}
