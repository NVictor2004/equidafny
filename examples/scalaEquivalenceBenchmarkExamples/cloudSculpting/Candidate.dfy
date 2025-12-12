function sculpteurDeNuage<A, B, C>(a: A, b: B, c: C, fuel: int, i1: int, i2: int, i3: int, a2b: A -> B, b2c: B -> C, c2a: C -> A): (int, int, int)
  requires (fuel >= 0) {
  leVraiSculpteurDeNuage(b2c, b, c, fuel, a2b, i2, a, i3, i1, c2a)
}

function leVraiSculpteurDeNuage<A, B, C>(b2c: B -> C, b: B, c: C, fuel: int, a2b: A -> B, i2: int, a: A, i3: int, i1: int, c2a: C -> A): (int, int, int)
  requires (fuel >= 0)
  decreases(fuel) {
  if (fuel == 0) then (i1, i2, i3)
  else
    var (ii1, ii2, ii3) := mixmash(i2, i3, i1);
    leVraiSculpteurDeNuage(b2c, a2b(a), b2c(b), fuel - 1, a2b, ii2, c2a(c), ii3, ii1, c2a)
}

function mixmash(i2: int, i3: int, i1: int): (int, int, int)
  decreases(if (i2 <= 0) then -i2 else i2) {
  if (i2 == 0) then (-1, i3, i1)
  else if (i2 > 0) then
    var (r1, r2, r3) := mixmash(i2 - 1, i3 + 1, i1);
    (r1 + 1, r2, r3)
  else
    var (r1, r2, r3) := mixmash(i2 + 1, i3 - 1, i1);
    (r1 - 1, r2, r3)
}
