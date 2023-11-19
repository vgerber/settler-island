class_name Hexagon
extends RefCounted

static func get_tile_position(q: int, r: int, tile_width: float, tile_height: float) -> Vector3:
	return Vector3(0.75 * tile_width * q, 0, q * 0.5 * tile_height) + Vector3(0, 0, r * tile_height)

static func get_coordinates_from_qr(q: int, r: int) -> Vector3i:
	return Vector3i(q, r, -q - r)

static func get_coordinates_from_qs(q: int, s: int) -> Vector3i:
	return Vector3i(q, -q - s, s)
	
static func get_coordinates_from_rs(r: int, s: int) -> Vector3i:
	return Vector3i(-r - s, r, s)

static func get_tile_neighbor_coordinates(tile: HexagonTile) -> Array[Vector3i]:
	var neighbor_coordinates: Array[Vector3i] = [Vector3i(1, 0, -1), Vector3i(0, 1, -1), Vector3i(-1, 1, 0), Vector3i(-1, 0, 1), Vector3i(0, -1, 1), Vector3i(1, -1, 0)]
	for neighbor_index in range(neighbor_coordinates.size()):
		neighbor_coordinates[neighbor_index] += tile.cube_coordinates
	return neighbor_coordinates

static func coordinates_to_position(coordinates: Vector3i, tile_size: Vector2) -> Vector3:
	return Vector3(0.75 * tile_size.x * coordinates.x, 0, coordinates.x * 0.5 * tile_size.y) + Vector3(0, 0, coordinates.y * tile_size.y)
