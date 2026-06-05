// MODEL

function libM(n: int): int {
    if(n == 1) then
        1
    else if(n < 1) then
        0
    else
        libM(n - 1) + libM(n - 2)
}
function fib(x: int): int {
    if(x < 5) then
        libM(x)
    else
        0
}

// CANDIDATE

function lib1(n: int): int {
    var a: int := 0;
    var b: int := 1;
    var i: int := 0;
    while(i < n){
        i += 1;
        var a := b;
        var b := a + b;
    }
    a
}
function fib1(x: int): int {
    if(x < 5) then
        lib1(x)
    else
        0
}