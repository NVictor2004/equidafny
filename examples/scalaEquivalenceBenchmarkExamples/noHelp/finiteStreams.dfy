/* Copyright 2009-2024 EPFL, Lausanne */

datatype Stream = SNil | SCons(x: int, tailFun: () -> Stream, sz: int)

function rank(s: Stream): int
  ensures rank(s) >= 0
  {
    match s
      case SCons(_, _, sz) => if (sz > 0) then sz else 0
      case _                           => 0
  }

function finiteM(s: Stream): bool
  decreases(rank(s)) {
  match s
    case SCons(_, tfun, sz)  => if rank(tfun()) >= sz then false else finiteM(tfun())
    case _ => true
  }

function finite(stream: Stream): bool
  decreases(rank(stream)) {
  match stream
    case SCons(_, tfun, sz) =>
      var tail := tfun();
      rank(tail) < sz && finite(tail)
    case SNil() =>
      true
  }