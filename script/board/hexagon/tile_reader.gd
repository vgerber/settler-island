class_name TileReader
extends RefCounted

static func tile_from_dict(tile: Dictionary) -> HexagonTile:
	var tile_type: int = tile["type"]
	if tile_type == 0:
		return FillerTile.from_dict(tile)
	elif tile_type == 1:
		return ResourceTile.from_dict(tile)
	return null
