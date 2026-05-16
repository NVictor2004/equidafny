datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function validAdjListM(adjList: seq<List<int>>, N: int, pos: int): bool
requires ((((N >= 1) && (pos >= 0)) && (pos <= N)) && (N == |adjList|))
decreases (pos)
{if (pos == 0) then true else (validListM(adjList[(pos - 1)], N) && validAdjListM(adjList, N, (pos - 1)))}

function validAdjList(adjList: seq<List<int>>, N: int, pos: int): bool
requires ((((N >= 1) && (pos >= 0)) && (pos <= N)) && (N == |adjList|))
decreases (pos)
{if (pos == 0) then true else if validAdjList(adjList, N, (pos - 1)) then validList(N, adjList[(pos - 1)]) else false}

function validList(N: int, l: List<int>): bool
requires (N >= 1)
{match l {
case Cons(h, t) => if ((h >= 0) && (h < N)) then validList(N, t) else false
case Nil => true
}
}

function validListM(list: List<int>, N: int): bool
requires (N >= 1)
{match list {
case Nil => true
case Cons(h, t) => (((h >= 0) && (h < N)) && validListM(t, N))
}
}

lemma validAdjListM_validAdjList_Equivalence(adjList: seq<List<int>>, N: int, pos: int)
requires ((((N >= 1) && (pos >= 0)) && (pos <= N)) && (N == |adjList|))
decreases (pos)
ensures (validAdjListM(adjList, N, pos) == validAdjList(adjList, N, pos))
{{if (pos == 0){}else {validListM_validList_Equivalence(adjList[(pos - 1)], N);validAdjListM_validAdjList_Equivalence(adjList, N, (pos - 1));}}}

lemma validListM_validList_Equivalence(list: List<int>, N: int)
requires (N >= 1)
ensures (validListM(list, N) == validList(N, list))
{{match list {
case Nil =>
case Cons(h, t) =>validListM_validList_Equivalence(t, N);
}
}}

