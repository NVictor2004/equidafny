// MODEL

function libM(n: int): int {
    if n > 0 then
        libM_helper(n, 1, 1)
    else
        0
}

function libM_helper(n: int, x: int, acc: int): int
    decreases n + 1 - x
{
    if x < n + 1 then
        libM_helper(n, x + 1, acc * x)
    else
        acc
}

function factorialM(x: int): int {
    if(x < 5) then
        libM(x)
    else
        0
    }

// CANDIDATE

function lib1(n: int): int {
    if(n <= 0) then
        0
    else if(n == 1) then
        1
    else
        n * lib1(n-1)
}
function factorial1(x: int): int {
    if(x < 5) then
        lib1(x)
    else
        0
}
