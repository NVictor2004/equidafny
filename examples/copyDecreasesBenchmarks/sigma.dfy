
// Needed to add a decreases clause here
function sigma(f: int -> int, a: int, b: int): int
  decreases b - a
{
  if (a > b) then 0 else f(a) + sigma(f, a + 1, b)
}
