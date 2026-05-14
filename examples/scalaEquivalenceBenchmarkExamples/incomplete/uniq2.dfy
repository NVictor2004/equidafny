// This file is testing batching of multiple model solutions
// Dafny does not have a feature to test batching
// However, Stainless was able to find that:
//   solution_2 and uniq2 are equivalent
//   solution_3 and uniq1 are equivalent
// So we can test if Dafny can prove these equivalences as well

// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(lst: List<T>): nat
  decreases(lst) {
  match lst {
    case Nil => 0
    case Cons(_, tl) => 1 + length(tl)
  }
}

function snoc<T>(l: List<T>, elem: T): List<T> {
  match l {
    case Nil => Cons(elem, Nil)
    case Cons(hd, tl) => Cons(hd, snoc(tl, elem))
  }
}

function remove_elem_1(e: int, lst: List<int>): List<int>
  decreases(lst) {
  match lst {
    case Nil => Nil
    case Cons(hd, tl) =>
      if (e == hd) then remove_elem_1(e, tl) else Cons(hd, remove_elem_1(e, tl))
  }
}

function solution_1(lst: List<int>): List<int>
  decreases(lst) {
  match lst {
    case Nil        => Nil
    case Cons(hd, tl) => Cons(hd, remove_elem_1(hd, solution_1(tl)))
  }
}

function drop_2(lst: List<int>, n: int): List<int>
  decreases(lst) {
  match lst {
    case Nil        => Nil
    case Cons(hd, tl) => if (hd == n) then drop_2(tl, n) else Cons(hd, drop_2(tl, n))
  }
}

// Removed @induct annotation from lst argument
lemma lemM(n: int, lst: List<int>)
  ensures length(drop_2(lst, n)) <= length(lst)
{}

function solution_2(lst: List<int>): List<int>
  decreases(length(lst)) {

  match lst {
    case Nil        => Nil
    case Cons(hd, tl) =>
      lemM(hd, tl);
      Cons(hd, solution_2(drop_2(tl, hd)))
  }
}

function is_in_3(lst: List<int>, a: int): bool
  decreases(lst) {
  match lst {
    case Nil        => false
    case Cons(hd, tl) => if (a == hd) then true else is_in_3(tl, a)
  }
}

function unique_3(lst1: List<int>, lst2: List<int>): List<int>
  decreases(lst1) {
  match lst1 {
    case Nil => lst2
    case Cons(hd, tl) =>
      if (is_in_3(lst2, hd)) then unique_3(tl, lst2) else unique_3(tl, snoc(lst2, hd))
  }
}

function solution_3(lst: List<int>): List<int> { unique_3(lst, Nil) }

function isNotIn_4(tlst: List<int>, c: int): bool
  decreases(tlst) {
  match tlst {
    case Nil        => true
    case Cons(hd, tl) => if (hd == c) then false else true && isNotIn_4(tl, c)
  }
}

function uniqSave_4(l1: List<int>, l2: List<int>): List<int>
  decreases(l1) {
  match l1 {
    case Nil => l2
    case Cons(hd, tl) =>
      if (isNotIn_4(l2, hd)) then
        uniqSave_4(tl, snoc(l2, hd))
      else
        uniqSave_4(tl, l2)
  }
}

function solution_4(lst: List<int>): List<int> {
  uniqSave_4(lst, Nil)
}

// CANDIDATE 1

function check(element: int, l: List<int>): bool
  decreases(l) {
  match l {
    case Nil        => false
    case Cons(hd, tl) => if (element == hd) then true else check(element, tl)
  }
}

function app(l1: List<int>, l2: List<int>): List<int>
  decreases(l1) {
  match l1 {
    case Nil => l2
    case Cons(hd, tl) =>
      if (check(hd, l2)) then app(tl, l2) else app(tl, snoc(l2, hd))
  }
}

function uniq1(lst: List<int>): List<int> {app(lst, Nil())}

lemma equivalence_check_isin3(lst: List<int>, a: int)
  ensures (check(a, lst) == is_in_3(lst, a))
{}

lemma equivalence_unique3_app(l1: List<int>, l2: List<int>)
  ensures (unique_3(l1, l2) == app(l1, l2))
{
  match l1
    case Nil =>
    case Cons(hd, _) => equivalence_check_isin3(l2, hd);
}

lemma equivalence_solution3_uniq1(lst: List<int>)
  ensures (solution_3(lst) == uniq1(lst))
{
  equivalence_unique3_app(lst, Nil);
}

// CANDIDATE 2

function drop(a: int, lst_0: List<int>): List<int>
  decreases(lst_0) {
  match lst_0 {
    case Nil => Nil
    case Cons(hd_0, tl_0) =>
      if (a == hd_0) then drop(a, tl_0) else Cons(hd_0, drop(a, tl_0))
  }
}

// Removed @induct annotation from lst argument
lemma lem2(a: int, lst: List<int>)
  ensures length(drop(a, lst)) <= length(lst)
{}

function uniq2(lst: List<int>): List<int>
  decreases(length(lst)) {
  match lst {
    case Nil => Nil
    case Cons(hd, tl) =>
      lem2(hd, tl);
      Cons(hd, uniq2(drop(hd, tl)))
  }
}

lemma equivalenceDrop(a: int, lst: List<int>)
  ensures (drop(a, lst) == drop_2(lst, a))
{}

lemma equivalence_solution2_uniq2(lst: List<int>)
  ensures (solution_2(lst) == uniq2(lst))
  decreases(length(lst))
{
  match lst
    case Nil => {}
    case Cons(hd, tl) =>
      lem2(hd, tl);
      equivalenceDrop(hd, tl);
}
