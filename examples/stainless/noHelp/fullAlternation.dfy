// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



// Fig. 12

function m1(n: int, flag: bool): int {
  if (n < 1) then 0
  else if (n == 1) then 1
  else m1(n - 1, !flag) + m1(n - 2, !flag)
}

function m2(n: int, mode: bool): int {
  if (n < 1) then 0
  else if (n == 1 || n == 2) then 1
  else
    var results := if (mode) then m2(n-2, !mode) + m2(n-2, !mode) + m2(n-3, !mode) else m2(n-1, !mode) + m2(n-2, !mode);
    results
}

lemma m2_equivalence_fib(n: int)
  requires n >= 2
  ensures m2(n, true) == m2(n - 1, false) + m2(n - 2, false)
{}
