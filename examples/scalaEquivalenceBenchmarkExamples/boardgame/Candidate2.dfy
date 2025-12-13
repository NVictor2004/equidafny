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
