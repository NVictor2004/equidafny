// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



  // Fig. 8
  // RVT times out due to KLEE timing out when trying to prove the base-case

  method p1(n: int, m: int) returns (res: int) {
    if (m < 1 || n < 1 || m > n) 0
    else if (m == 1 || n == 1 || m == n) 1
    else p1(n-1, m-1) + p1(n-1, m)
  }

  method p2(n: int, m: int) returns (res: int) {
    if (m < 1 || n < 1 || m > n) 0
    else if (m == 1 || n == 1 || m == n) 1
    else p2(n-1, m-1) + p2 (n-2 , m-1) + p2 (n-2 , m)
  }
}
