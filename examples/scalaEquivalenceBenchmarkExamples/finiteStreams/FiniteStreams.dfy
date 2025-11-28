/* Copyright 2009-2024 EPFL, Lausanne */



sealed abstract class Stream:
  method rank = {
    this match
      case SCons(_, _, sz) if (sz > 0) => sz
      case _                           => int(0)
 }.ensuring(_ >= 0)
case class SCons(x: int, tailFun: () => Stream, sz: int) extends Stream
case class SNil() extends Stream

method finiteM(s: Stream): bool =
  decreases(s.rank)
  s match
    case SCons(_, tfun, sz) if tfun().rank >= sz =>
      false
    case SCons(_, tfun, sz) =>
      finiteM(tfun())
    case _ =>
      true


method finite(stream: Stream): bool =
  decreases(stream.rank)
  stream match
    case SCons(_, tfun, sz) =>
      val tail = tfun()
      tail.rank < sz && finite(tail)
    case SNil() =>
      true
