function sigmaM(f :int -> int, a :int, b :int): int
{s(a, b, f, 0)}function sigma1(f :int -> int, a :int, b :int): int
decreases (if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{if (a > b) then 0 else sigma_rec(0, a, b, f)}function sigma_rec(sum :int, i :int, b :int, f :int -> int): int
decreases (if (b == i) then 2 else if (b > i) then 2 + b - i else i - b)
{if (i < b) then sigma_rec(sum + f(i), i + 1, b, f) else if (i == b) then sum + f(i) else 0}function s(a :int, b :int, f :int -> int, acc :int): int
decreases (if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{if (a > b) then acc else s(a + 1, b, f, acc + f(a))}lemma sigma1Equivalence(f :int -> int, a :int, b :int)
decreases (if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
ensures sigmaM(f, a, b) == sigma1(f, a, b)
{{}}