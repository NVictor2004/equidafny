
// Testing subfunction matching within subfunctions
// That is, we do not only try to match function appearing in top-level `eval` (mul and myMul)
// but also functions transitively appearing in mul and myMul
// Furthermore, Candidate mySub arguments are swapped
  // Top level
  method eval(x: int, y: int): int = mul(x, y)

  method mul(x: int, y: int) returns (res: int) {
    decreases(if (x <= 0) -x else x)
    if (x == 0) int(0)
    else if (x > 0) add(mul(x - 1, y), y)
    else sub(mul(x + 1, y), y)
  }

  method add(x: int, y: int) returns (res: int) {
    decreases(if (x <= 0) -x else x)
    if (x == 0) y
    else if (x > 0) add(x - 1, y + 1)
    else add(x + 1, y - 1)
  }

  method sub(x: int, y: int) returns (res: int) {
    decreases(if (x <= 0) -x else x)
    if (x == 0) -y
    else if (x > 0) sub(x - 1, y - 1)
    else sub(x + 1, y + 1)
  }
}
