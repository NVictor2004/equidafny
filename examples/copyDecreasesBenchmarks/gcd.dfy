
// The decreases clause needed to be added here
function gcd(a: int, b: int): int
  requires(a >= 0 && b >= 0)
  decreases b
{
  if b == 0 then a
  else if a < b then gcd(b,a)
  else gcd(b, a % b)
}
