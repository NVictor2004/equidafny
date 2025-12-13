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

lemma m2_equivalence_no_flag(n: int, flag: bool)
  ensures (m2(n, flag) == m2(n, !flag))
{
  if n >= 3 {
    if flag {
      assert m2(n, flag) == m2(n-2, !flag) + m2(n-2, !flag) + m2(n-3, !flag);
      assert m2(n, !flag) == m2(n-1, flag) + m2(n-2, flag);
      m2_equivalence_no_flag(n - 2, flag);
      m2_equivalence_no_flag(n - 3, flag);
      m2_equivalence_helper(n - 1, flag);
    } else {
      assert m2(n, flag) == m2(n-1, !flag) + m2(n-2, !flag);
      assert m2(n, !flag) == m2(n-2, flag) + m2(n-2, flag) + m2(n-3, flag);
      m2_equivalence_helper(n - 1, flag);
      m2_equivalence_no_flag(n - 2, flag);
      m2_equivalence_no_flag(n - 1, flag);
    }
  }
}

lemma m2_equivalence_helper(n: int, flag: bool)
  requires (n >= 2)
  ensures (m2(n, flag) == m2(n - 1, flag) + m2(n - 2, flag))
{
  if (n >= 3) {
    if flag {
      assert m2(n, flag) == m2(n-2, !flag) + m2(n-2, !flag) + m2(n-3, !flag);
      m2_equivalence_no_flag(n - 2, flag);
      m2_equivalence_no_flag(n - 3, flag);
      assert m2(n, flag) == m2(n-2, flag) + m2(n-2, flag) + m2(n-3, flag);
      m2_equivalence_helper(n - 1, flag);
    } else {
      assert m2(n, flag) == m2(n-1, !flag) + m2(n-2, !flag);
      m2_equivalence_no_flag(n - 2, flag);
      m2_equivalence_no_flag(n - 1, flag);
      assert m2(n, flag) == m2(n-1, flag) + m2(n-2, flag);
    }
  }
}

lemma equivalence(n: int, flag: bool)
  ensures (m1(n, flag) == m2(n, flag))
{
  if n >= 2 {
    m2_equivalence_helper(n, flag);
    equivalence(n - 2, !flag);
  }
}
