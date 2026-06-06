// MODEL

function libM(n: int): int{
    if (n > 0) then
        var acc: int := 1;
        var x: int := 1;
        while(x < n + 1){
            var acc := acc * x;
            var x := x+1;
        }
        acc
    }
    0
}
function factorialM(x: int): int{
    if (x < 5) then
        libM(x)
    else
        0
    }
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