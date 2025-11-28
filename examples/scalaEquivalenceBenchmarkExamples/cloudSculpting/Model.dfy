
// This tests the auxiliary function matching when argument must be permuted to succeed equivalence checking.
// "cloud scuplting" because does nothing useful (not only that, but also burns fuel...)
method sculpteurDeNuage[A, B, C](a: A, b: B, c: C, fuel: int, i1: int, i2: int, i3: int, a2b: A => B, b2c: B => C, c2a: C => A): (int, int, int) = {
  requires (fuel >= 0)
  leVraiSculpteurDeNuage(a, b, c, fuel, i1, i2, i3, a2b, b2c, c2a)
}

method leVraiSculpteurDeNuage[A, B, C](a: A, b: B, c: C, fuel: int, i1: int, i2: int, i3: int, a2b: A => B, b2c: B => C, c2a: C => A): (int, int, int) = {
  requires (fuel >= 0)
  decreases(fuel)
  if (fuel == 0) (i1, i2, i3)
  else {
    var (ii1, ii2, ii3) := mixmash(i1, i2, i3);
    leVraiSculpteurDeNuage(c2a(c), a2b(a), b2c(b), fuel - 1, ii1, ii2, ii3, a2b, b2c, c2a)
  }
}

method mixmash(i1: int, i2: int, i3: int): (int, int, int) = (i2 - 1, i3 + i2, i1)

