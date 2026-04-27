/* Copyright 2009-2024 EPFL, Lausanne */

import stainless.lang._
import stainless.collection._
import stainless.annotation._

object defs {

  case class Tile(
    base: TileBase,
    feature: Option[Feature],
    resource: Option[Resource],
    construction: Option[Construction]
  )

  // Hexagon tiles, cylinder world (i.e. wraps around x-axis)
  case class WorldMap(tiles: List[Tile], width: BigInt, height: BigInt) {
    require(width > 0 && height > 0)
    require(tiles.length == width * height)
  }

  enum TileBase {
    case FlatTerrain(base: BaseTerrain)
    case HillTerrain(base: BaseTerrain)
    case Mountain()
    case Lake()
    case Coast()
    case Ocean()
  }

  enum BaseTerrain {
    case Plains()
    case Grassland()
    case Desert()
    case Tundra()
    case Snow()
  }

  enum Feature {
    case Forest()
    case RainForest()
    case Marsh()
  }

  enum Resource {
    case Iron()
    case Wheat()
    case Rice()
    case Stone()
    case Crabs()
    case Fish()
    case Coal()
  }

  enum Construction {
    case City(id: BigInt)
    case District(kind: DistrictKind)
    case Exploitation(kind: ResourceImprovement)
  }

  enum DistrictKind {
    case Campus()
    case IndustrialZone()
  }

  enum ResourceImprovement {
    case Farm()
    case Fishery()
    case Mine()
    case Quarry()
  }
}

import defs._

object Model {

  // Determining whether a placement is suitable for settling
  // -Rules: no other city in a 2-tile range
  // -The tile must be adequate for settling (flat or hill terrain, and must not have another city or district on it)
  def validCitySettlementM(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    require(wm.width > 4)
    tileOkForCityM(wm, x, y) && noOtherCitiesInRangeM(wm, x, y)
  }

  @mkTest
  def testsValidCitySettlement: List[(WorldMap, BigInt, BigInt)] = List(
    testValidCitySettlement1,
    testValidCitySettlement2,
    testValidCitySettlement3,
  )

  def testValidCitySettlement1: (WorldMap, BigInt, BigInt) = {
    // Ok, can be settled
    val G = Tile(TileBase.FlatTerrain(BaseTerrain.Grassland()), None(), None(), None())
    val X = G // where we would like to settle
    val wm = List(
            G, G, G, G, G,
          G, G, G, G, G,
        G, X, G, G, G,
      G, G, G, G, G,
    )
    // Note: the coordinates are upside down
    (WorldMap(wm, 5, 4), 1, 2)
  }

  def testValidCitySettlement2: (WorldMap, BigInt, BigInt) = {
    // A lake in the center, we can't settle there
    val G = Tile(TileBase.FlatTerrain(BaseTerrain.Grassland()), None(), None(), None())
    val L = Tile(TileBase.Lake(), None(), None(), None())
    val wm = List(
          G, G, G, G, G,
        G, G, L, G, G,
      G, G, G, G, G,
    )
    // Note: the coordinates are upside down
    (WorldMap(wm, 5, 3), 2, 1)
  }

  def testValidCitySettlement3: (WorldMap, BigInt, BigInt) = {
    // A city in the second ring of the place where we want to settle
    val G = Tile(TileBase.FlatTerrain(BaseTerrain.Grassland()), None(), None(), None())
    val X = G // where we would like to settle
    val Y = Tile(TileBase.FlatTerrain(BaseTerrain.Grassland()), None(), None(), Some(Construction.City(42))) // Oh no, someone's already there :(
    val wm = List(
            G, G, Y, G, G,
          G, G, G, G, G,
        G, X, G, G, G,
      G, G, G, G, G,
    )
    // Note: the coordinates are upside down
    (WorldMap(wm, 5, 4), 1, 2)
  }

  ///////////////////////////////////////////////////////////////////////////

  def tileOkForCityM(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    val tile = wm(x, y)
    val baseOk = tile.base match {
      case TileBase.FlatTerrain(_) => true
      case TileBase.HillTerrain(_) => true
      case _ => false
    }
    val ctorOk = tile.construction match {
      case None() => true
      case Some(Construction.Exploitation(_)) => true // res. improvement removed on settling
      case Some(Construction.District(_)) => false
      case Some(Construction.City(_)) => false
    }
    baseOk && ctorOk
  }

  def noOtherCitiesInRangeM(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    require(wm.width > 4)
    def loop(ls: List[Tile]): Boolean = {
      decreases(ls)
      ls match {
        case Cons(t, rest) => t.construction match {
          case Some(Construction.City(_)) => false
          case _ => loop(rest)
        }
        case Nil() => true
      }
    }
    loop(allTilesWithinRadiusM(wm, x, y, 2))
  }

  // Note: includes the x,y tile as well
  def allTilesWithinRadiusM(wm: WorldMap, x: BigInt, y: BigInt, radius: BigInt): List[Tile] = {
    require(0 <= y && y < wm.height)
    require(radius >= 0)
    require(2 * radius < wm.width) // To avoid repetition of tiles due to wrapping

    def allRings(currRadius: BigInt): List[Tile] = {
      require(0 <= currRadius && currRadius <= radius)
      decreases(radius - currRadius)
      val atThisRadius = collectTilesInRingM(wm, x, y, currRadius)
      if (currRadius == radius) atThisRadius
      else atThisRadius ++ allRings(currRadius + 1)
    }

    allRings(0)
  }


  def diffXM(i: BigInt, radius: BigInt): BigInt = {
    require(radius > 0)
    require(0 <= i)
    val corner = i / radius
    val rest = i % radius
    if (corner == 0) rest
    else if (corner == 1) radius
    else if (corner == 2) radius - rest
    else if (corner == 3) -rest
    else if (corner == 4) -radius
    else rest - radius
  }

  def diffYM(i: BigInt, radius: BigInt): BigInt = {
    require(radius > 0)
    require(0 <= i)
    val corner = i / radius
    val rest = i % radius
    if (corner == 0) radius - rest
    else if (corner == 1) -rest
    else if (corner == 2) -radius
    else if (corner == 3) rest - radius
    else if (corner == 4) rest
    else radius
  }

  def collectTilesInRingM(wm: WorldMap, x: BigInt, y: BigInt, radius: BigInt): List[Tile] = {
    require(0 <= y && y < wm.height)
    require(radius >= 0)
    require(2 * radius < wm.width)

    def allTilesM(i: BigInt): List[Tile] = {
      require(0 <= i && i < 6 * radius)
      decreases(6 * radius - i)

      val xx = x + diffXM(i, radius)
      val yy = y + diffYM(i, radius)
      val includeThis = {
        if (0 <= yy && yy < wm.height) List(wm(xx, yy))
        else Nil[Tile]()
      }
      if (i == 6 * radius - 1) includeThis
      else includeThis ++ allTilesM(i + 1)
    }
    if (radius == 0) List(wm(x, y))
    else allTilesM(0)
  }

  extension (wm: WorldMap) {
    def apply(x: BigInt, y: BigInt): Tile = {
      require(0 <= y && y < wm.height)
      val xx = (x % wm.width + wm.width) % wm.width
      val ix = y * wm.width + xx
      wm.tiles(ix)
    }
  }
}

object Candidate {

  def validCitySettlement(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    require(wm.width > 4)
    noCitiesInHorizon(wm, x, y) && tileFreeForSettlement(wm, x, y)
  }

  /////////////////////////////////////

  def tileInWorld(wm: WorldMap, x: BigInt, y: BigInt): Tile = {
    require(0 <= y && y < wm.height)
    val xx = (x % wm.width + wm.width) % wm.width
    val ix = y * wm.width + xx
    wm.tiles(ix)
  }

  def tileFreeForSettlement(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    val tile = tileInWorld(wm, x, y)
    (tile.base match {
      case TileBase.FlatTerrain(_) => true
      case TileBase.HillTerrain(_) => true
      case _ => false
    }) && (tile.construction match {
      case Some(Construction.City(_)) => false
      case Some(Construction.District(_)) => false
      case None() => true
      case Some(Construction.Exploitation(_)) => true
    })
  }

  def noCitiesInHorizon(wm: WorldMap, x: BigInt, y: BigInt): Boolean = {
    require(0 <= y && y < wm.height)
    require(wm.width > 4)
    def loop(ls: List[Tile]): Boolean = {
      ls match {
        case Cons(t, rest) => t.construction match {
          case Some(Construction.City(_)) => false
          case _ => loop(rest)
        }
        case Nil() => true
      }
    }
    loop(allTilesWithinRadius(wm, x, y, 2))
  }

  def diffX(i: BigInt, radius: BigInt): BigInt = {
    require(radius > 0)
    require(0 <= i)
    val corner = i / radius
    val rest = i % radius
    if (corner == 0) rest
    else if (corner == 1) radius
    else if (corner == 2) radius - rest
    else if (corner == 3) -rest
    else if (corner == 4) -radius
    else rest - radius
  }

  def diffY(i: BigInt, radius: BigInt): BigInt = {
    require(radius > 0)
    require(0 <= i)
    val corner = i / radius
    val rest = i % radius
    if (corner == 0) radius - rest
    else if (corner == 1) -rest
    else if (corner == 2) -radius
    else if (corner == 3) rest - radius
    else if (corner == 4) rest
    else radius
  }

  def allTilesWithinRadius(wm: WorldMap, x: BigInt, y: BigInt, radius: BigInt): List[Tile] = {
    require(0 <= y && y < wm.height)
    require(radius >= 0)
    require(2 * radius < wm.width)

    def loop(currRadius: BigInt): List[Tile] = {
      require(0 <= currRadius && currRadius <= radius)
      val next = if (currRadius == radius) Nil[Tile]() else loop(currRadius + 1)
      collectTilesInRing(wm, currRadius, x, y) ++ next
    }
    loop(0)
  }

  def collectTilesInRing(wm: WorldMap, radius: BigInt, x: BigInt, y: BigInt): List[Tile] = {
    require(0 <= y && y < wm.height)
    require(radius >= 0)
    require(2 * radius < wm.width)
    def loop(i: BigInt): List[Tile] = {
      require(radius > 0)
      require(0 <= i && i < 6 * radius)
      val xx = x + diffX(i, radius)
      val yy = y + diffY(i, radius)
      val lhs = if (yy < 0 || yy >= wm.height) Nil() else List(tileInWorld(wm, xx, yy))
      val rhs = if (i == 6 * radius - 1) Nil() else loop(i + 1)
      lhs ++ rhs
    }
    if (radius == 0) List(tileInWorld(wm, x, y))
    else loop(0)
  }
}
