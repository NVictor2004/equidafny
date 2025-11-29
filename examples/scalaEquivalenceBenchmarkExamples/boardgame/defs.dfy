










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


case class Tile(
  base: TileBase,
  feature: Option[Feature],
  resource: Option[Resource],
  construction: Option[Construction]
)

// Hexagon tiles, cylinder world (i.e. wraps around x-axis)
case class WorldMap(tiles: List<Tile>, width: int, height: int) {
  requires (width > 0 && height > 0)
  requires (|tiles| == width * height)
}

sealed trait TileBase
  case class FlatTerrain(base: BaseTerrain) extends TileBase
  case class HillTerrain(base: BaseTerrain) extends TileBase
}

sealed trait BaseTerrain
}

sealed trait Feature
  // etc.
}

sealed trait Resource
  // etc.
}

sealed trait Construction
  case class City(id: int) extends Construction
  case class District(kind: DistrictKind) extends Construction
  case class Exploitation(kind: ResourceImprovement) extends Construction
}

sealed trait DistrictKind
  // etc.
}

sealed trait ResourceImprovement
  // etc.
}
