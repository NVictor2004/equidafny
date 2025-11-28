

method adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  adj(wm, x, y + 1, districtKind) +
    adj(wm, x + 1, y, districtKind) +
    adj(wm, x + 1, y - 1, districtKind) +
    adj(wm, x, y - 1, districtKind) +
    adj(wm, x - 1, y, districtKind) +
    adj(wm, x - 1, y + 1, districtKind)
}

method adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  // oops, forgot to check for OOB y...
  val tile = tileInWorld(wm, x, y)
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
      val resAdj = tile.resource match {
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


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

method validCitySettlement(wm: WorldMap, x: int, y: int): bool = {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  noCitiesInHorizon(wm, x, y) // oops, forgot to check whether the tile to settle on is ok...
}

/////////////////////////////////////

method tileInWorld(wm: WorldMap, x: int, y: int): Tile = {
  requires (0 <= y && y < wm.height)
  val xx = (x % wm.width + wm.width) % wm.width
  val ix = y * wm.width + xx
  wm.tiles(ix)
}

method noCitiesInHorizon(wm: WorldMap, x: int, y: int): bool = {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  method loop(ls: List[Tile]): bool = {
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

method collectTilesWithinRadius(wm: WorldMap, x: int, y: int, radius: int): List[Tile] = {
  requires (0 <= y && y < wm.height)
  requires (radius >= 0)
  requires (2 * radius < wm.width)

  method allRings(currRadius: int): List[Tile] = {
    decreases(radius - currRadius)
    requires (0 <= currRadius && currRadius <= radius)
    val atThisRadius = collectTilesInRing(wm, x, y, currRadius)
    if (currRadius == radius) atThisRadius
    else atThisRadius ++ allRings(currRadius + 1)
  }

  allRings(0)
}

method collectTilesInRing(wm: WorldMap, x: int, y: int, ring: int): List[Tile] = {
  requires (0 <= y && y < wm.height)
  requires (ring >= 0)
  requires (2 * ring < wm.width)

  method loop(i: int): List[Tile] = {
    requires (ring > 0)
    requires (0 <= i && i < 6 * ring)
    decreases(6 * ring - i)

    val corner = i / ring
    val rest = i % ring
    val diffX = {
      if (corner == 0) rest
      else if (corner == 1) ring
      else if (corner == 2) ring - rest
      else if (corner == 3) -rest
      else if (corner == 4) -ring
      else rest - ring
    }
    val diffY = {
      if (corner == 0) ring - rest
      else if (corner == 1) -rest
      else if (corner == 2) -ring
      else if (corner == 3) rest - ring
      else if (corner == 4) rest
      else ring
    }

    val xx = x + diffX
    val yy = y + diffY
    val includeThis = {
      if (0 <= yy && yy < wm.height) List(tileInWorld(wm, xx, yy))
      else Nil[Tile]()
    }
    if (i == 6 * ring - 1) includeThis
    else includeThis ++ loop(i + 1)
  }
  if (ring > 0) loop(0)
  else List(tileInWorld(wm, x, y))
}


