class_name HexagonMap
extends RefCounted

var tiles: Array[HexagonTile] = []

func clear() -> void:
	tiles.clear()

func add_tile(tile: HexagonTile) -> void:
	assert(get_tile(tile.cube_coordinates) == null)
	tiles.push_back(tile)

func get_tile(coordinates: Vector3i) -> HexagonTile:
	for tile in tiles:
		if tile.cube_coordinates == coordinates:
			return tile
	return null

func get_tile_neighbors(tile: HexagonTile) -> Array[HexagonTile]:
	var neighbors: Array[HexagonTile] = []
	for coordinates in Hexagon.get_tile_neighbor_coordinates(tile):
		var neighbor_tile = get_tile(coordinates)
		if neighbor_tile != null:
			neighbors.push_back(neighbor_tile)
	return neighbors

static func from_dict(dict: Dictionary) -> HexagonMap:
	var map = HexagonMap.new()
	map.tiles.assign(dict["tiles"].map(func(tile: Dictionary): return TileReader.tile_from_dict(tile)))
	return map

func to_dict() -> Dictionary:
	return {
		"tiles": tiles.map(func(tile): return tile.to_dict())
	}
