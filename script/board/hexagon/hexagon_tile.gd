class_name HexagonTile
extends RefCounted

var cube_coordinates = Vector3i(0, 0, 0)

func _init(p_cube_coordinates: Vector3i):
	cube_coordinates = p_cube_coordinates

static func from_dict(dict: Dictionary) -> HexagonTile:
	return HexagonTile.new(Vector3i(dict["cube_coordinates"][0], dict["cube_coordinates"][1], dict["cube_coordinates"][2]))

func to_dict() -> Dictionary:
	return { "cube_coordinates": [cube_coordinates.x, cube_coordinates.y, cube_coordinates.z] }

func get_id() -> String:
	return "(%s,%s,%s)" % [str(cube_coordinates.x), str(cube_coordinates.y), str(cube_coordinates.z)]
