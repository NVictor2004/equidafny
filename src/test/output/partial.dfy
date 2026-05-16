ghost function fM(x: int, p: int -> bool): int
requires (!p(x) || existsM((j: int) => ((j < x) && maxNegPM(j, p))))
decreases (if !p(x) then 0 else (x - eliminate_existsM((j: int) => ((j < x) && maxNegPM(j, p)))))
{if p(x) then termM(x, p);
fM((x - 1), p) else x}

ghost function f(x: int, p: int -> bool): int
requires (!p(x) || existsF((j: int) => ((j < x) && maxNegP(p, j))))
decreases (if !p(x) then 0 else equiv(x, p);
(x - eliminate_existsM((j: int) => ((j < x) && maxNegPM(j, p)))))
{var t := p(x);
if t then termF(x, p);
f((x - 1), p) else x}

ghost function eliminate_existsM<T(!new)>(p: T -> bool): T
requires existsM(p)
ensures p(eliminate_existsM(p))
{var res :| p(res);
res}

ghost function maxNegP(p: int -> bool, j: int): bool
{if p(j) then false else forall k :: (!p(k) ==> (k <= j))}

ghost function existsF<T(!new)>(p: T -> bool): bool
{!forall t :: !p(t)}

ghost function existsM<T(!new)>(p: T -> bool): bool
{!forall t: T :: !p(t)}

ghost function maxNegPM(j: int, p: int -> bool): bool
{(!p(j) && forall k :: (!p(k) ==> (k <= j)))}

lemma fM_f_Equivalence(x: int, p: int -> bool)
requires (!p(x) || existsM((j: int) => ((j < x) && maxNegPM(j, p))))
decreases (if !p(x) then 0 else (x - eliminate_existsM((j: int) => ((j < x) && maxNegPM(j, p)))))
ensures (fM(x, p) == f(x, p))
{{if p(x){termM(x, p);}else {}}}

lemma equivalence_f(x: int, p: int -> bool)
requires (!p(x) || existsM((j: int) => ((j < x) && maxNegPM(j, p))))
requires (!p(x) || existsF((j: int) => ((j < x) && maxNegP(p, j))))
decreases (if !p(x) then 0 else equiv(x, p);
(x - eliminate_existsM((j: int) => ((j < x) && maxNegPM(j, p)))))
ensures (fM(x, p) == f(x, p))
{{if p(x){termM(x, p);termF(x, p);equivalence_f((x - 1), p);}}}

lemma termF(x: int, p: int -> bool)
requires existsF((j: int) => ((j < x) && maxNegP(p, j)))
ensures (!p((x - 1)) || existsF((j: int) => ((j < (x - 1)) && maxNegP(p, j))))
{{equiv(x, p);termM(x, p);equiv((x - 1), p);}}

lemma termM(x: int, p: int -> bool)
requires existsM((j: int) => ((j < x) && maxNegPM(j, p)))
ensures (!p((x - 1)) || existsM((j: int) => ((j < (x - 1)) && maxNegPM(j, p))))
{{var j :| ((j < x) && maxNegPM(j, p));assert ((j < (x - 1)) ==> exists j :: ((j: int) => ((j < (x - 1)) && maxNegPM(j, p)))(j));}}

lemma equiv(x: int, p: int -> bool)
ensures (existsM((j: int) => ((j < x) && maxNegPM(j, p))) <==> existsF((j: int) => ((j < x) && maxNegP(p, j))))
{{assert forall j: int :: (!((j: int) => ((j < x) && maxNegPM(j, p)))(j) <==> !((j: int) => ((j < x) && maxNegP(p, j)))(j));}}

