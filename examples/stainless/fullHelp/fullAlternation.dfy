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

// These lemmas can be greatly simplified, but I will keep them here anyway

// lemma m2_equivalence_mode(n: int)
//   ensures m2(n, true) == m2(n, false)
// {
//   if n >= 3 {
//       assert m2(n, true) == m2(n-2, false) + m2(n-2, false) + m2(n-3, false);
//       assert m2(n, false) == m2(n-1, true) + m2(n-2, true);
//       m2_equivalence_fib(n - 1);
//       assert m2(n, true) == m2(n-2, false) + m2(n-1, true);
//       m2_equivalence_mode(n - 2);
//       assert m2(n, true) == m2(n-1, true) + m2(n-2, true);
//   }
// }

// lemma m2_equivalence_fib(n: int)
//   requires n >= 2
//   ensures m2(n, true) == m2(n - 1, false) + m2(n - 2, false)
// {
//   if n >= 3 {
//       assert m2(n, true) == m2(n-2, false) + m2(n-2, false) + m2(n-3, false);
//       m2_equivalence_fib(n - 1);
//       assert m2(n, true) == m2(n-1, true) + m2(n-2, false);
//       m2_equivalence_mode(n - 1);
//       assert m2(n, true) == m2(n-1, false) + m2(n-2, false);
//   }
// }

lemma m2_equivalence_fib(n: int)
  requires n >= 2
  ensures m2(n, true) == m2(n - 1, false) + m2(n - 2, false)
{}

lemma equivalence(n: int, flag: bool)
  ensures m2(n, flag) == m1(n, flag)
{
  if n >= 2 { m2_equivalence_fib(n); }
}
