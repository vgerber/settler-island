class_name HexagonMapScene
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

func add_tile(tile: HexagonTileScene) -> void:
	assert(get_tile(tile.cube_coordinates) == null)
	tiles.add_child(tile)
	
func get_tile(coordinates: Vector3i) -> HexagonTileScene:
	for child in tiles.get_children():
		if (child as HexagonTileScene).cube_coordinates == coordinates:
			return child
	return null

func get_tile_by_id(tile_id: String) -> HexagonTileScene:
	for tile in tiles:
		tile = tile as HexagonTileScene
		if tile.name == tile_id:
			return tile
	return null

func get_tile_neighbors(cube_coordinates: Vector3i) -> Array[HexagonTile]:
	var neighbors: Array[HexagonTile] = []
	for coordinates in Hexagon.get_neighbor_coordinates(cube_coordinates):
		var neighbor_tile = get_tile(coordinates)
		if neighbor_tile != null:
			neighbors.push_back(neighbor_tile)
	return neighbors
