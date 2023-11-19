class_name FillerTile
extends HexagonTile

func _init(p_cube_coordinates: Vector3i):
	super(p_cube_coordinates)

func to_dict() -> Dictionary:
	var tile = super.to_dict()
	tile["type"] = 0
	return tile
