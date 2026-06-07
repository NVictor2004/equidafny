// MODEL

function trM(n: int): int {
    trMHelper(n, 0, 0)
}

function trMHelper(n: int, i: int, result: int): int
{
    if i < n then trMHelper(n, i, result + i)
    else result
}

function fM(m: int): int {
    if (m > 0) then
        var result := trM(m - 1);
        result + m
    else
        0
}

// CANDIDATE

function tr1(n: int): int {
    tr1Helper(n, 0, 0)
}

function tr1Helper(n: int, i: int, result: int): int
    decreases n - i
{
    if i < n then tr1Helper(n, i + 1, result + i)
    else result
}

function f1(m: int): int {
    if (m > 0) then
        var result := tr1(m - 1);
        result + m
    else
        0
}