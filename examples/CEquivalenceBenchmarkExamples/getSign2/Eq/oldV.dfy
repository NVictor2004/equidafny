function lib(x: int): int {
  if (x == 0)
     return 0;
  if (x < 0)
     return -1;
  else
     return 1;
}
function client(x: int): int{
  if (x > 0) {
    return lib(x);
  }
  return x;
}