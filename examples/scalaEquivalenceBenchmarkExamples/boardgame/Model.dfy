










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
method adjacencyBonus1(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  adj(wm, x, y + 1, districtKind) +
  adj(wm, x + 1, y, districtKind) +
  adj(wm, x + 1, y - 1, districtKind) +
  adj(wm, x, y - 1, districtKind) +
  adj(wm, x - 1, y, districtKind) +
  adj(wm, x - 1, y + 1, districtKind)
}

method adjacencyBonus2(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)

  method sum(acc: int, ts: List<Tile>) returns (res: int) {
    decreases(ts) {
    ts match {
      case Nil() => acc
      case Cons(tile, rest) => sum(acc + adj(tile, districtKind), rest)
    }
  }
  sum(0, collectTilesInRing(wm, x, y, 1))
}

method testsAdjacencyBonus: List<(WorldMap, int, int, DistrictKind)> = List(
  testsAdjacencyBonus1,
)

method testsAdjacencyBonus1: (WorldMap, int, int, DistrictKind) = {
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

method adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  if (y < 0 || y >= wm.height) { var result := int(0); return result; }
  else { return adj(tileInWorld(wm, x, y), districtKind); }
}

method adj(tile: Tile, districtKind: DistrictKind) returns (res: int) {
  (districtKind, tile) match {
    case (DistrictKind.Campus, Tile(TileBase.Mountain, _, _, _)) => int(2)
    case (DistrictKind.Campus, Tile(_, _, _, Some(Construction.City(_)))) => int(1)
    case (DistrictKind.Campus, Tile(_, _, _, Some(Construction.District(_)))) => int(1)
    case (DistrictKind.Campus, _) => int(0)
    case (DistrictKind.IndustrialZone, Tile(_, _, res, ctor)) =>
      var resAdj := res match {;
        case Some(Resource.Iron) => int(2)
        case Some(Resource.Coal) => int(2)
        case _ => int(0)
      }
      var resCtor := ctor match {;
        case Some(Construction.City(_)) => int(1)
        case Some(Construction.District(_)) => int(1)
        case Some(Construction.Exploitation(ResourceImprovement.Mine)) => int(1)
        case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => int(2)
        case _ => int(0)
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
method validCitySettlement(wm: WorldMap, x: int, y: int) returns (res: bool)
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  tileOkForCity(wm, x, y) && noOtherCitiesInRange(wm, x, y)
}

method testsValidCitySettlement: List<(WorldMap, int, int)> = List(
  testValidCitySettlement1,
  testValidCitySettlement2,
  testValidCitySettlement3,
)

method testValidCitySettlement1: (WorldMap, int, int) = {
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

method testValidCitySettlement2: (WorldMap, int, int) = {
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

method testValidCitySettlement3: (WorldMap, int, int) = {
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

method tileOkForCity(wm: WorldMap, x: int, y: int) returns (res: bool)
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

method noOtherCitiesInRange(wm: WorldMap, x: int, y: int) returns (res: bool)
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  method loop(ls: List<Tile>): bool = {
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
method allTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int) returns (res: List<Tile>)
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width) // To avoid repetition of tiles due to wrapping

  method allRings(currRadius: int): List<Tile> = {
    decreases(radius - currRadius) {
    requires (0 <= currRadius && currRadius <= radius)
    var atThisRadius := collectTilesInRing(wm, x, y, currRadius);
    if (currRadius == radius) { return atThisRadius; }
    else { return atThisRadius ++ allRings(currRadius + 1); }
  }

  allRings(0)
}

method collectTilesInRing(wm: WorldMap, x: int, y: int, radius: int) returns (res: List<Tile>)
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  method loop(i: int): List<Tile> = {
    requires (radius > 0)
    requires (0 <= i && i < 6 * radius)
    decreases(6 * radius - i)

    var corner := i / radius;
    var rest := i % radius;
    var diffX := {;
      if (corner == 0) { return rest; }
      else if (corner == 1) { return radius; }
      else if (corner == 2) { var result := radius - rest; return result; }
      else if (corner == 3) { return -rest; }
      else if (corner == 4) { return -radius
      else rest - radius; }
    }
    var diffY := {;
      if (corner == 0) { return radius - rest; }
      else if (corner == 1) { return -rest; }
      else if (corner == 2) { return -radius; }
      else if (corner == 3) { return rest - radius; }
      else if (corner == 4) { return rest; }
      else { return radius; }
    }

    var xx := x + diffX;
    var yy := y + diffY;
    var includeThis := {;
      if (0 <= yy && yy < wm.height) { var result := List(tileInWorld(wm, xx, yy)); return result; }
      else { return Nil[Tile](); }
    }
    if (i == 6 * radius - 1) { return includeThis; }
    else { return includeThis ++ loop(i + 1); }
  }
  if (radius == 0) { var result := List(tileInWorld(wm, x, y)); return result; }
  else { return loop(0); }
}

// Note: Using extension method here on wm will create a match with candidates `tileInWorld`.
// Since we must be Scala 2-compatible, we could be tempted in having an implicit class.
// However, the signature will be different to candidates `tileInWorld` (leading to equiv. checking resulting in unknown)
// As such, we use a plain function...
method tileInWorld(wm: WorldMap, x: int, y: int) returns (res: Tile)
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}
