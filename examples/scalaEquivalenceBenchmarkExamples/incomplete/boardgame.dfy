datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

datatype Tile = Tile(
  base: TileBase,
  feature: Option<Feature>,
  resource: Option<Resource>,
  construction: Option<Construction>
)

// Hexagon tiles, cylinder world (i.e. wraps around x-axis)
datatype WorldMap = WorldMap(tiles: List<Tile>, width: int, height: int) {
  requires (width > 0 && height > 0)
  requires (|tiles| == width * height)
}

datatype TileBase = FlatTerrain(base: BaseTerrain) | HillTerrain(base: BaseTerrain) | Mountain | Lake | Coast | Ocean
datatype BaseTerrain = Plains | Grassland | Desert | Tundra | Snow
datatype Feature =  Forest | RainForest | Marsh
datatype Resource = Iron  | Wheat | Rice | Stone | Crabs | Fish | Coal
datatype Construction = City(id: int) | District(DKind: DistrictKind) | Exploitation(EKind: ResourceImprovement)
datatype DistrictKind = Campus | IndustrialZone
datatype ResourceImprovement = Farm | Fishery | Mine | Quarry

// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


// Part 1. Calculating adjacency bonus
// Rules:
//   -For an industrial zone:
//      -Adjacent iron, coal or quarry: +1
//      -Adjacent mine, city or district: +1/2
//   -For a campus:
//      -Adjacent mountain: +1
//      -Adjacent city or district: +1/2
// Since we have half point, the result is doubled to have integers
function adjacencyBonus1(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  adj(wm, x, y + 1, districtKind) +
  adj(wm, x + 1, y, districtKind) +
  adj(wm, x + 1, y - 1, districtKind) +
  adj(wm, x, y - 1, districtKind) +
  adj(wm, x - 1, y, districtKind) +
  adj(wm, x - 1, y + 1, districtKind)
}

function adjacencyBonus2(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)

  function sum(acc: int, ts: List<Tile>): int {
    decreases(ts) {
    ts match {
      case Nil() => acc
      case Cons(tile, rest) => sum(acc + adj(tile, districtKind), rest)
    }
  }
  sum(0, collectTilesInRing(wm, x, y, 1))
}

function testsAdjacencyBonus: List<(WorldMap, int, int, DistrictKind)> = List(
  testsAdjacencyBonus1,
)

function testsAdjacencyBonus1: (WorldMap, int, int, DistrictKind) = {
  var G := Tile(TileBase.FlatTerrain(BaseTerrain.Grassland), None(), None(), None());
  var M := Tile(TileBase.Mountain, None(), None(), None());
  var X := G // The emplacement where we would like to compute for potential adjacency;
  var wm := List(;
          G, M, X, M, G,
        G, G, G, M, G,
      G, M, G, G, G,
    G, G, G, G, G,
  )
  // Note: the coordinates are upside down
  (WorldMap(wm, 5, 4), 2, 0, DistrictKind.Campus)
}

//////////////////////

function adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  if (y < 0 || y >= wm.height) then 0
  else adj(tileInWorld(wm, x, y), districtKind)
}

function adj(tile: Tile, districtKind: DistrictKind): int {
  (districtKind, tile) match {
    case (DistrictKind.Campus, Tile(TileBase.Mountain, _, _, _)) => 2
    case (DistrictKind.Campus, Tile(_, _, _, Some(Construction.City(_)))) => 1
    case (DistrictKind.Campus, Tile(_, _, _, Some(Construction.District(_)))) => 1
    case (DistrictKind.Campus, _) => 0
    case (DistrictKind.IndustrialZone, Tile(_, _, res, ctor)) =>
      var resAdj := res match {;
        case Some(Resource.Iron) => 2
        case Some(Resource.Coal) => 2
        case _ => 0
      }
      var resCtor := ctor match {;
        case Some(Construction.City(_)) => 1
        case Some(Construction.District(_)) => 1
        case Some(Construction.Exploitation(ResourceImprovement.Mine)) => 1
        case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => 2
        case _ => 0
      }
      resAdj + resCtor
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

// Part 2. Determining whether a placement is suitable for settling
// -Rules: no other city in a 2-tile range
// -The tile must be adequate for settling (flat or hill terrain, and must not have another city or district on it)
function validCitySettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  tileOkForCity(wm, x, y) && noOtherCitiesInRange(wm, x, y)
}

function testsValidCitySettlement: List<(WorldMap, int, int)> = List(
  testValidCitySettlement1,
  testValidCitySettlement2,
  testValidCitySettlement3,
)

function testValidCitySettlement1: (WorldMap, int, int) = {
  // Ok, can be settled
  var G := Tile(TileBase.FlatTerrain(BaseTerrain.Grassland), None(), None(), None());
  var X := G // where we would like to settle;
  var wm := List(;
          G, G, G, G, G,
        G, G, G, G, G,
      G, X, G, G, G,
    G, G, G, G, G,
  )
  // Note: the coordinates are upside down
  (WorldMap(wm, 5, 4), 1, 2)
}

function testValidCitySettlement2: (WorldMap, int, int) = {
  // A lake in the center, we can't settle there
  var G := Tile(TileBase.FlatTerrain(BaseTerrain.Grassland), None(), None(), None());
  var L := Tile(TileBase.Lake, None(), None(), None());
  var wm := List(;
        G, G, G, G, G,
      G, G, L, G, G,
    G, G, G, G, G,
  )
  // Note: the coordinates are upside down
  (WorldMap(wm, 5, 3), 2, 1)
}

function testValidCitySettlement3: (WorldMap, int, int) = {
  // A city in the second ring of the place where we want to settle
  var G := Tile(TileBase.FlatTerrain(BaseTerrain.Grassland), None(), None(), None());
  var X := G // where we would like to settle;
  var Y := Tile(TileBase.FlatTerrain(BaseTerrain.Grassland), None(), None(), Some(Construction.City(42))) // Oh no, someone's already there :(;
  var wm := List(;
          G, G, Y, G, G,
        G, G, G, G, G,
      G, X, G, G, G,
    G, G, G, G, G,
  )
  // Note: the coordinates are upside down
  (WorldMap(wm, 5, 4), 1, 2)
}

///////////////////////////////////////////////////////////////////////////

function tileOkForCity(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  var tile := tileInWorld(wm, x, y);
  var baseOk := tile.base match {;
    case TileBase.FlatTerrain(_) => true
    case TileBase.HillTerrain(_) => true
    case _ => false
  }
  var ctorOk := tile.construction match {;
    case None() => true
    case Some(Construction.Exploitation(_)) => true // res. improvement removed on settling
    case Some(Construction.District(_)) => false
    case Some(Construction.City(_)) => false
  }
  baseOk && ctorOk
}

function noOtherCitiesInRange(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  function loop(ls: List<Tile>): bool = {
    decreases(ls) {
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

// Note: includes the x,y tile as well
function allTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width) // To avoid repetition of tiles due to wrapping

  function allRings(currRadius: int): List<Tile> = {
    decreases(radius - currRadius) {
    requires (0 <= currRadius && currRadius <= radius)
    var atThisRadius := collectTilesInRing(wm, x, y, currRadius);
    if (currRadius == radius) then atThisRadius
    else atThisRadius ++ allRings(currRadius + 1)
  }

  allRings(0)
}

function collectTilesInRing(wm: WorldMap, x: int, y: int, radius: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  function loop(i: int): List<Tile> = {
    requires (radius > 0)
    requires (0 <= i && i < 6 * radius)
    decreases(6 * radius - i)

    var corner := i / radius;
    var rest := i % radius;
    var diffX := {;
      if (corner == 0) then rest
      else if (corner == 1) then radius
      else if (corner == 2) then radius - rest
      else if (corner == 3) then -rest
      else if (corner == 4) then -radius
      else rest - radius
    }
    var diffY := {;
      if (corner == 0) then radius - rest
      else if (corner == 1) then -rest
      else if (corner == 2) then -radius
      else if (corner == 3) then rest - radius
      else if (corner == 4) then rest
      else radius
    }

    var xx := x + diffX;
    var yy := y + diffY;
    var includeThis := {;
      if (0 <= yy && yy < wm.height) then List(tileInWorld(wm, xx, yy))
      else Nil[Tile]()
    }
    if (i == 6 * radius - 1) then includeThis
    else includeThis ++ loop(i + 1)
  }
  if (radius == 0) then List(tileInWorld(wm, x, y))
  else loop(0)
}

// Note: Using extension function here on wm will create a match with candidates `tileInWorld`.
// Since we must be Scala 2-compatible, we could be tempted in having an implicit class.
// However, the signature will be different to candidates `tileInWorld` (leading to equiv. checking resulting in unknown)
// As such, we use a plain function...
function tileInWorld(wm: WorldMap, x: int, y: int): Tile
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

// CANDIDATE 1

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function adj(tile: Tile): int {
  match districtKind {
    case DistrictKind.Campus => tile.base match {
      case TileBase.Mountain => 2
      case _ => tile.construction match {
        case Some(Construction.City(_))  => 1
        case Some(Construction.District(_)) => 1
        case _ => 0
      }
    }
    case DistrictKind.IndustrialZone =>
      var resAdj := tile.resource match {;
        case Some(Resource.Iron) => 2
        case Some(Resource.Coal) => 2
        case _ => 0
      }
      tile.construction match {
        case Some(Construction.City(_)) => resAdj + 1
        case Some(Construction.District(_)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Mine)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => resAdj + 2
        case _ => resAdj
      }
  }
}

function sum(ts: List<Tile>, acc: int): int {
  decreases(ts) {
  ts match {
    case Nil() => acc
    case Cons(tile, rest) => sum(rest, acc + adj(tile))
  }
}

function adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4) {
  
  sum(collectTilesInRing(wm, x, y, 1), 0)
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

function validCitySettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  noCitiesInHorizon(wm, x, y) && tileFreeForSettlement(wm, x, y)
}

/////////////////////////////////////

function tileInWorld(wm: WorldMap, x: int, y: int): Tile
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

function tileFreeForSettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  var tile := tileInWorld(wm, x, y);
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

function noCitiesInHorizon(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  function loop(ls: List<Tile>): bool = {
    decreases(ls) {
    ls match {
      case Cons(t, rest) => t.construction match {
        case Some(Construction.City(_)) => false
        case _ => loop(rest)
      }
      case Nil() => true
    }
  }
  loop(collectTilesWithinRadius(wm, x, y, 2))
}

function collectTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  function allRings(currRadius: int): List<Tile> = {
    decreases(radius - currRadius) {
    requires (0 <= currRadius && currRadius <= radius)
    var atThisRadius := collectTilesInRing(wm, x, y, currRadius);
    if (currRadius == radius) then atThisRadius
    else atThisRadius ++ allRings(currRadius + 1)
  }

  allRings(0)
}

function collectTilesInRing(wm: WorldMap, x: int, y: int, ring: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (ring >= 0)
  requires (2 * ring < wm.width)

  function loop(i: int): List<Tile> = {
    requires (ring > 0)
    requires (0 <= i && i < 6 * ring)
    decreases(6 * ring - i)

    var corner := i / ring;
    var rest := i % ring;
    var diffX := {;
      if (corner == 0) then rest
      else if (corner == 1) then ring
      else if (corner == 2) then ring - rest
      else if (corner == 3) then -rest
      else if (corner == 4) then -ring
      else rest - ring
    }
    var diffY := {;
      if (corner == 0) then ring - rest
      else if (corner == 1) then -rest
      else if (corner == 2) then -ring
      else if (corner == 3) then rest - ring
      else if (corner == 4) then rest
      else ring
    }

    var xx := x + diffX;
    var yy := y + diffY;
    var includeThis := {;
      if (0 <= yy && yy < wm.height) then List(tileInWorld(wm, xx, yy))
      else Nil[Tile]()
    }
    if (i == 6 * ring - 1) then includeThis
    else includeThis ++ loop(i + 1)
  }
  if (ring > 0) then loop(0)
  else List(tileInWorld(wm, x, y))
}

// CANDIDATE 2

function adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  adj(wm, x, y + 1, districtKind) +
    adj(wm, x + 1, y, districtKind) +
    adj(wm, x + 1, y - 1, districtKind) +
    adj(wm, x, y - 1, districtKind) +
    adj(wm, x - 1, y, districtKind) +
    adj(wm, x - 1, y + 1, districtKind)
}

function adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  if (y < 0 || y >= wm.height) then 0
  else {
    var tile := tileInWorld(wm, x, y);
    districtKind match {
      case DistrictKind.Campus => tile.base match {
        case TileBase.Mountain => 2
        case _ => tile.construction match {
          case Some(Construction.City(_))  => 1
          case Some(Construction.District(_)) => 1
          case _ => 0
        }
      }
      case DistrictKind.IndustrialZone =>
        var resAdj := tile.resource match {;
          case Some(Resource.Iron) => 2
          case Some(Resource.Coal) => 2
          case _ => 0
        }
        tile.construction match {
          case Some(Construction.City(_)) => resAdj + 1
          case Some(Construction.District(_)) => resAdj + 1
          case Some(Construction.Exploitation(ResourceImprovement.Mine)) => resAdj + 1
          case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => resAdj + 2
          case _ => resAdj
        }
    }
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

function validCitySettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  var tile := tileInWorld(wm, x, y);
  tile.base match {
    case TileBase.FlatTerrain(_) => true
    case TileBase.HillTerrain(_) => true
    case _ => false
  }
}

/////////////////////////////////////

function tileInWorld(wm: WorldMap, x: int, y: int): Tile
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

// CANDIDATE 3

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  adj(wm, x, y + 1, districtKind) +
    adj(wm, x + 1, y, districtKind) +
    adj(wm, x + 1, y - 1, districtKind) +
    adj(wm, x, y - 1, districtKind) +
    adj(wm, x - 1, y, districtKind) +
    adj(wm, x - 1, y + 1, districtKind)
}

function adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  // oops, forgot to check for OOB y...
  var tile := tileInWorld(wm, x, y);
  districtKind match {
    case DistrictKind.Campus => tile.base match {
      case TileBase.Mountain => 2
      case _ => tile.construction match {
        case Some(Construction.City(_))  => 1
        case Some(Construction.District(_)) => 1
        case _ => 0
      }
    }
    case DistrictKind.IndustrialZone =>
      var resAdj := tile.resource match {;
        case Some(Resource.Iron) => 2
        case Some(Resource.Coal) => 2
        case _ => 0
      }
      tile.construction match {
        case Some(Construction.City(_)) => resAdj + 1
        case Some(Construction.District(_)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Mine)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => resAdj + 2
        case _ => resAdj
      }
  }
}


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

function validCitySettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  noCitiesInHorizon(wm, x, y) // oops, forgot to check whether the tile to settle on is ok...
}

/////////////////////////////////////

function tileInWorld(wm: WorldMap, x: int, y: int): Tile
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

function noCitiesInHorizon(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  function loop(ls: List<Tile>): bool = {
    decreases(ls) {
    ls match {
      case Cons(t, rest) => t.construction match {
        case Some(Construction.City(_)) => false
        case _ => loop(rest)
      }
      case Nil() => true
    }
  }
  loop(collectTilesWithinRadius(wm, x, y, 2))
}

function collectTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  function allRings(currRadius: int): List<Tile> = {
    decreases(radius - currRadius) {
    requires (0 <= currRadius && currRadius <= radius)
    var atThisRadius := collectTilesInRing(wm, x, y, currRadius);
    if (currRadius == radius) then atThisRadius
    else atThisRadius ++ allRings(currRadius + 1)
  }

  allRings(0)
}

function collectTilesInRing(wm: WorldMap, x: int, y: int, ring: int): List<Tile>
  requires (0 <= y && y < wm.height)
  requires (ring >= 0)
  requires (2 * ring < wm.width)

  function loop(i: int): List<Tile> = {
    requires (ring > 0)
    requires (0 <= i && i < 6 * ring)
    decreases(6 * ring - i)

    var corner := i / ring;
    var rest := i % ring;
    var diffX := {;
      if (corner == 0) then rest
      else if (corner == 1) then ring
      else if (corner == 2) then ring - rest
      else if (corner == 3) then -rest
      else if (corner == 4) then -ring
      else rest - ring
    }
    var diffY := {;
      if (corner == 0) then ring - rest
      else if (corner == 1) then -rest
      else if (corner == 2) then -ring
      else if (corner == 3) then rest - ring
      else if (corner == 4) then rest
      else ring
    }

    var xx := x + diffX;
    var yy := y + diffY;
    var includeThis := {;
      if (0 <= yy && yy < wm.height) then List(tileInWorld(wm, xx, yy))
      else Nil[Tile]()
    }
    if (i == 6 * ring - 1) then includeThis
    else includeThis ++ loop(i + 1)
  }
  if (ring > 0) then loop(0)
  else List(tileInWorld(wm, x, y))
}

// CANDIDATE 4

function adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  // No, one must still compute adjacency even for tiles on the y-border of the map
  if (0 < y && y < wm.height - 1) {
    adj(wm, x, y + 1, districtKind) then +
      adj(wm, x + 1, y, districtKind) then +
      adj(wm, x + 1, y - 1, districtKind) then +
      adj(wm, x, y - 1, districtKind) then +
      adj(wm, x - 1, y, districtKind) then +
      adj(wm, x - 1, y + 1, districtKind)
  } else 0
}

function adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind): int {
  requires (0 <= y && y < wm.height)
  var tile := tileInWorld(wm, x, y);
  districtKind match {
    case DistrictKind.Campus => tile.base match {
      case TileBase.Mountain => 2
      case _ => tile.construction match {
        case Some(Construction.City(_))  => 1
        case Some(Construction.District(_)) => 1
        case _ => 0
      }
    }
    case DistrictKind.IndustrialZone =>
      var resAdj := tile.resource match {;
        case Some(Resource.Iron) => 2
        case Some(Resource.Coal) => 2
        case _ => 0
      }
      tile.construction match {
        case Some(Construction.City(_)) => resAdj + 1
        case Some(Construction.District(_)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Mine)) => resAdj + 1
        case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => resAdj + 2
        case _ => resAdj
      }
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

function validCitySettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  // Desperately trying to do that by-hand, but forgets about the second ring...
  var (p1x, p1y) := (x, y + 1);
  var (p2x, p2y) := (x + 1, y);
  var (p3x, p3y) := (x + 1, y - 1);
  var (p4x, p4y) := (x, y - 1);
  var (p5x, p5y) := (x - 1, y);
  var (p6x, p6y) := (x - 1, y + 1);
  tileFreeForSettlement(wm, x, y) && notACity(wm, p1x, p1y) &&
    notACity(wm, p2x, p2y) &&
    notACity(wm, p3x, p3y) &&
    notACity(wm, p4x, p4y) &&
    notACity(wm, p5x, p5y) &&
    notACity(wm, p6x, p6y)
}

/////////////////////////////////////

function tileInWorld(wm: WorldMap, x: int, y: int): Tile
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

function tileFreeForSettlement(wm: WorldMap, x: int, y: int): bool
  requires (0 <= y && y < wm.height)
  var tile := tileInWorld(wm, x, y);
  (tile.base match {
    case TileBase.FlatTerrain(_) => true
    case TileBase.HillTerrain(_) => true
    case _ => false
  }) && notACity(wm, x, y) && notADistrict(wm, x, y)
}

function notACity(wm: WorldMap, x: int, y: int): bool
  !(0 <= y && y < wm.height) || {
    var tile := tileInWorld(wm, x, y);
    tile.construction match {
      case Some(Construction.City(_)) => false
      case Some(Construction.District(_)) => true
      case Some(Construction.Exploitation(_)) => true
      case None() => true
    }
  }
}
function notADistrict(wm: WorldMap, x: int, y: int): bool
  !(0 <= y && y < wm.height) || {
    var tile := tileInWorld(wm, x, y);
    tile.construction match {
      case Some(Construction.District(_)) => false
      case Some(Construction.City(_)) => true
      case Some(Construction.Exploitation(_)) => true
      case None() => true
    }
  }
}


