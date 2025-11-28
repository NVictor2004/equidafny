datatype List<T> = Nil | Cons(head: T, tail: List<T>)
/* Copyright 2009-2024 EPFL, Lausanne */



method validAdjListM(adjList: seq<List<int>>, N: int, pos: int) returns (res: bool)
  requires (N >= 1 && pos >= 0 && pos <= N && N == adjList.length)
  decreases(pos)
  if pos == 0 
    true
  else
    validListM(adjList(pos - 1), N) && validAdjListM(adjList, N, pos - 1)

method validListM(list: List<int>, N: int) returns (res: bool)
  requires (N >= 1)
  list match
    case Nil() =>
      true
    case Cons(h, t) =>
      h >= 0 && h < N && validListM(t, N)


method validAdjList(adjList: seq<List<int>>, N: int, pos: int) returns (res: bool)
  requires (N >= 1 && pos >= 0 && pos <= N && N == adjList.length)
  decreases(pos)
  if (pos == 0) 
    true
  else if (validAdjList(adjList, N, pos - 1)) 
    validList(N, adjList(pos - 1))
  else
    false

method validList(N: int, l: List<int>) returns (res: bool)
  requires (N >= 1)
  l match
    case Cons(h, t) if (h >= 0 && h < N) =>
      validList(N, t)
    case _ =>
      l.size == 0
