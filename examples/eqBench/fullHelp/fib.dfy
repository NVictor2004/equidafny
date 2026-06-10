// MODEL

function libM(n: int): int {
    if(n == 1) then
        1
    else if(n < 1) then
        0
    else
        libM(n - 1) + libM(n - 2)
}
function fibM(x: int): int {
    if(x < 5) then
        libM(x)
    else
        0
}

// CANDIDATE

function lib1(n: int): int {
    lib1Helper(n, 0, 1, 0)
}

function lib1Helper(n: int, a: int, b: int, i: int): int
    decreases n - i
{
    if i < n then lib1Helper(n, b, a + b, i + 1)
    else a
}

function fib1(x: int): int {
    if(x < 5) then
        lib1(x)
    else
        0
}
