// MODEL

function trM(n: int): int {
    var i := 0;
    var result := 0;
    while (i < n) {
        var result := result + i;
    }
    result
}
function fM(m: int): int {
    if (m > 0) then
        var result := trM(m - 1);
        var result := result + m;
    else
        var result := 0;
    }
    result
}

// CANDIDATE

function tr1(n: int): int {
    var i := 0;
    var result := 0;
    while (i < n) {
        var result := result + i;
        var i := i +1;
    }
    result
}
function f1(m: int): int {
    if (m > 0) then
        var result := tr1(m - 1);
        var result := result + m;
    else
        var result := 0;
    }
    result
}