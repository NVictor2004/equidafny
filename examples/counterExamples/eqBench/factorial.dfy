// MODEL

function libM(n: int): int{
    if (n > 0) then libMHelper(n, 1, 1)
    else 0
}

function libMHelper(n: int, acc: int, x: int): int
    decreases n + 1 - x
{
    if x < n + 1 then libMHelper(n, acc * x, x + 1)
    else acc
}

function factorialM(x: int): int{
    if (x < 5) then libM(x)
    else 0
}

// CANDIDATE

function lib1(n: int): int{
    if (n <= 0) then
        1
    else
        n * lib1(n-1)
}
function factorial1(x: int): int{
    if (x < 5) then
        lib1(x)
    else
        0
}