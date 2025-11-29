












method adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  requires (wm.width > 4)
  // No, one must still compute adjacency even for tiles on the y-border of the map
  if (0 < y && y < wm.height - 1) {
    adj(wm, x, y + 1, districtKind) { return +; }
      adj(wm, x + 1, y, districtKind) { return +; }
      adj(wm, x + 1, y - 1, districtKind) { return +; }
      adj(wm, x, y - 1, districtKind) { return +; }
      adj(wm, x - 1, y, districtKind) { return +; }
      adj(wm, x - 1, y + 1, districtKind)
  } else { var result := int(0); return result; }
}

method adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  var tile := tileInWorld(wm, x, y);
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

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

method validCitySettlement(wm: WorldMap, x: int, y: int) returns (res: bool)
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
  }) && notACity(wm, x, y) && notADistrict(wm, x, y)
}

method notACity(wm: WorldMap, x: int, y: int) returns (res: bool)
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
method notADistrict(wm: WorldMap, x: int, y: int) returns (res: bool)
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
