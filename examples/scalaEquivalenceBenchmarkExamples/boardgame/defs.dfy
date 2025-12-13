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