
// Example 2: Get Unique Values From a List

// Creating a list data structure
datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function append(l1: List<int>, l2: List<int>): List<int>
{
  match l1
  case Nil => l2
  case Cons(hd, tl) => Cons(hd, append(tl, l2))
}


// Define Reference solution

function find(lst: List<int>, n: int): bool
{
  match lst
  case Nil => false
  case Cons(hd, tl) => n == hd || find(tl, n)
}

function unique(l: List<int>, r: List<int>): List<int>
{
  match l
  case Nil => r
  case Cons(hd, tl) =>
    if !find(r, hd) then unique(tl, append(r, Cons(hd, Nil)))
    else unique(tl, r)
}

function uniqR(lst: List<int>): List<int>
{
  unique(lst, Nil)
}

// Define Student solution
// Had to simplify this function to avoid defining foldRight
function isin(a: int, lst: List<int>): bool
{
  match lst
  case Nil => false
  case Cons(hd, tl) => a == hd || isin(a, tl)
}

// This requires a decreases clause
function distinct(a: List<int>, b: List<int>): List<int>
  decreases b
{
  match b
  case Nil => a
  case Cons(hd, tl) =>
    if isin(hd, a) then distinct(a, tl)
    else distinct(append(a, Cons(hd, Nil)), tl)
}

function uniqA(lst: List<int>): List<int>
{
  distinct(Nil, lst)
}

// Proving equivalence of both functions
// Dafny needs help here
lemma uniqEquivalence(l: List<int>)
  ensures uniqR(l) == uniqA(l)
{
  uniqEquivalenceHelper(l, Nil);
}

// Requires two helper lemmas
lemma uniqEquivalenceHelper(l: List<int>, r: List<int>)
  ensures unique(l, r) == distinct(r, l)
{
  match l
  case Nil => {}
  case Cons(hd, tl) => findEquivalence(r, hd);
}

lemma findEquivalence(l: List<int>, n: int)
  ensures find(l, n) == isin(n, l)
{
}
