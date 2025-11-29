










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function remove_elem_1(e: int, lst: List<int>): List<int>
  decreases(lst) {
  lst match {
    case Nil() => Nil()
    case Cons(hd, tl) =>
      if (e == hd) remove_elem_1(e, tl) else hd :: remove_elem_1(e, tl)
  }
}

function solution_1(lst: List<int>): List<int>
  decreases(lst) {
  lst match {
    case Nil()        => Nil()
    case Cons(hd, tl) => hd :: remove_elem_1(hd, solution_1(tl))
  }
}

function drop_2(lst: List<int>, n: int): List<int>
  decreases(lst) {
  lst match {
    case Nil()        => Nil()
    case Cons(hd, tl) => if (hd == n) drop_2(tl, n) else hd :: drop_2(tl, n)
  }
}

function lemma_2(n: int, @induct lst: List<int>): Unit
}.ensuring(drop_2(lst, n).size <= lst.size)

function solution_2(lst: List<int>): List<int>
  decreases(lst.size) {

  function lem(n: int, @stainless.annotation.induct lst: List<int>): Unit = {
    ()
 }.ensuring(drop_2(lst, n).size <= lst.size)

  lst match {
    case Nil()        => Nil()
    case Cons(hd, tl) =>
      lem(hd, tl)
      hd :: solution_2(drop_2(tl, hd))
  }
}

function is_in_3(lst: List<int>, a: int): bool
  decreases(lst) {
  lst match {
    case Nil()        => false
    case Cons(hd, tl) => if (a == hd) true else is_in_3(tl, a)
  }
}

function unique_3(lst1: List<int>, lst2: List<int>): List<int>
  decreases(lst1) {
  lst1 match {
    case Nil() => lst2
    case Cons(hd, tl) =>
      if (is_in_3(lst2, hd)) unique_3(tl, lst2) else unique_3(tl, lst2 ++ List<int>(hd))
  }
}

function solution_3(lst: List<int>): List<int>) { unique_3(lst, Nil() }

function solution_4(lst: List<int>): List<int>

  function isNotIn_4(tlst: List<int>, c: int): bool = {
    decreases(tlst) {
    tlst match {
      case Nil()        => true
      case Cons(hd, tl) => if (hd == c) false else true && isNotIn_4(tl, c)
    }
  }

  function uniqSave_4(l1: List<int>, l2: List<int>): List<int> = {
    decreases(l1) {
    l1 match {
      case Nil() => { l2 }
      case Cons(hd, tl) =>
        if (isNotIn_4(l2, hd)) {
          uniqSave_4(tl, l2 ++ List(hd))
        } else {
          uniqSave_4(tl, l2)
        }
    }
  }
  uniqSave_4(lst, Nil())

}
