class_name HexagonMap
extends Node3D

var gap_size: float = 0.5

var tiles = Node3D.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tiles)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear() -> void:
	for tile in tiles.get_children():
		tile.queue_free()

func add_tile(tile: HexagonTile) -> void:
	assert(get_tile(tile.cube_coordinates) == null)
	tiles.add_child(tile)

func get_tile_position(q: int, r: int, tile_width: float, tile_height: float) -> Vector3:
	return Vector3(0.75 * tile_width * q, 0, q * 0.5 * tile_height) + Vector3(0, 0, r * tile_height)

static func get_coordinates_from_qr(q: int, r: int) -> Vector3i:
	return Vector3i(q, r, -q - r)

static func get_coordinates_from_qs(q: int, s: int) -> Vector3i:
	return Vector3i(q, -q - s, s)
	
static func get_coordinates_from_rs(r: int, s: int) -> Vector3i:
	return Vector3i(-r - s, r, s)



func get_tile(coordinates: Vector3i) -> HexagonTile:
	for child in tiles.get_children():
		if (child as HexagonTile).cube_coordinates == coordinates:
			return child
	return null

func get_tile_neighbor_coordinates(tile: HexagonTile) -> Array[Vector3i]:
	var neighbor_coordinates: Array[Vector3i] = [Vector3i(1, 0, -1), Vector3i(0, 1, -1), Vector3i(-1, 1, 0), Vector3i(-1, 0, 1), Vector3i(0, -1, 1), Vector3i(1, -1, 0)]
	for neighbor_index in range(neighbor_coordinates.size()):
		neighbor_coordinates[neighbor_index] += tile.cube_coordinates
	return neighbor_coordinates

func get_tile_neighbors(tile: HexagonTile) -> Array[HexagonTile]:
	var neighbors: Array[HexagonTile] = []
	for coordinates in get_tile_neighbor_coordinates(tile):		
		var neighbor_tile = get_tile(coordinates)
		if neighbor_tile != null:
			neighbors.push_back(neighbor_tile)
	return neighbors

func coordinates_to_position(coordinates: Vector3i, tile_size: Vector2) -> Vector3:
	return Vector3(0.75 * tile_size.x * coordinates.x, 0, coordinates.x * 0.5 * tile_size.y) + Vector3(0, 0, coordinates.y * tile_size.y)
