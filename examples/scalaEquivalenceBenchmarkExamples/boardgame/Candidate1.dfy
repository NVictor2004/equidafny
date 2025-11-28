datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  method adj(tile: Tile) returns (res: int) {
    districtKind match {
      case DistrictKind.Campus => tile.base match {
        case TileBase.Mountain => int(2)
        case _ => tile.construction match {
          case Some(Construction.City(_))  => int(1)
          case Some(Construction.District(_)) => int(1)
          case _ => int(0)
        }
      }
      case DistrictKind.IndustrialZone =>
        var resAdj := tile.resource match {;
          case Some(Resource.Iron) => int(2)
          case Some(Resource.Coal) => int(2)
          case _ => int(0)
        }
        tile.construction match {
          case Some(Construction.City(_)) => resAdj + int(1)
          case Some(Construction.District(_)) => resAdj + int(1)
          case Some(Construction.Exploitation(ResourceImprovement.Mine)) => resAdj + int(1)
          case Some(Construction.Exploitation(ResourceImprovement.Quarry)) => resAdj + int(2)
          case _ => resAdj
        }
    }
  }
  method sum(ts: List<Tile>, acc: int) returns (res: int) {
    decreases(ts)
    ts match {
      case Nil() => acc
      case Cons(tile, rest) => sum(rest, acc + adj(tile))
    }
  }
  sum(collectTilesInRing(wm, x, y, 1), 0)
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

method validCitySettlement(wm: WorldMap, x: int, y: int) returns (res: bool)
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  noCitiesInHorizon(wm, x, y) && tileFreeForSettlement(wm, x, y)
}

/////////////////////////////////////

method tileInWorld(wm: WorldMap, x: int, y: int) returns (res: Tile)
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}

method tileFreeForSettlement(wm: WorldMap, x: int, y: int) returns (res: bool)
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

method noCitiesInHorizon(wm: WorldMap, x: int, y: int) returns (res: bool)
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  method loop(ls: List<Tile>): bool = {
    decreases(ls)
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

method collectTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int) returns (res: List<Tile>)
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  method allRings(currRadius: int): List<Tile> = {
    decreases(radius - currRadius)
    requires (0 <= currRadius && currRadius <= radius)
    var atThisRadius := collectTilesInRing(wm, x, y, currRadius);
    if (currRadius == radius) atThisRadius
    else atThisRadius ++ allRings(currRadius + 1)
  }

  allRings(0)
}

method collectTilesInRing(wm: WorldMap, x: int, y: int, ring: int) returns (res: List<Tile>)
  requires (0 <= y && y < wm.height)
  requires (ring >= 0)
  requires (2 * ring < wm.width)

  method loop(i: int): List<Tile> = {
    requires (ring > 0)
    requires (0 <= i && i < 6 * ring)
    decreases(6 * ring - i)

    var corner := i / ring;
    var rest := i % ring;
    var diffX := {;
      if (corner == 0) rest
      else if (corner == 1) ring
      else if (corner == 2) ring - rest
      else if (corner == 3) -rest
      else if (corner == 4) -ring
      else rest - ring
    }
    var diffY := {;
      if (corner == 0) ring - rest
      else if (corner == 1) -rest
      else if (corner == 2) -ring
      else if (corner == 3) rest - ring
      else if (corner == 4) rest
      else ring
    }

    var xx := x + diffX;
    var yy := y + diffY;
    var includeThis := {;
      if (0 <= yy && yy < wm.height) List(tileInWorld(wm, xx, yy))
      else Nil[Tile]()
    }
    if (i == 6 * ring - 1) includeThis
    else includeThis ++ loop(i + 1)
  }
  if (ring > 0) loop(0)
  else List(tileInWorld(wm, x, y))
}


