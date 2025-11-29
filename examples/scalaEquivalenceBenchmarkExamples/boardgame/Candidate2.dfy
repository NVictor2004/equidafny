








method adjacencyBonus(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  requires (0 <= y && y < wm.height)
  adj(wm, x, y + 1, districtKind) +
    adj(wm, x + 1, y, districtKind) +
    adj(wm, x + 1, y - 1, districtKind) +
    adj(wm, x, y - 1, districtKind) +
    adj(wm, x - 1, y, districtKind) +
    adj(wm, x - 1, y + 1, districtKind)
}

method adj(wm: WorldMap, x: int, y: int, districtKind: DistrictKind) returns (res: int) {
  if (y < 0 || y >= wm.height) int(0)
  else {
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
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

method validCitySettlement(wm: WorldMap, x: int, y: int) returns (res: bool)
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

method tileInWorld(wm: WorldMap, x: int, y: int) returns (res: Tile)
  requires (0 <= y && y < wm.height)
  var xx := (x % wm.width + wm.width) % wm.width;
  var ix := y * wm.width + xx;
  wm.tiles(ix)
}
