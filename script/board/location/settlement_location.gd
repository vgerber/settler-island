class_name SettlementLocation
extends RefCounted

enum BuildType {
	NONE = -1,
	VILLAGE = 0,
	CITY = 1
}

var id: String
var player_id: String
var type: BuildType
var neighbor_tiles: Array[Vector3i]

func _init(p_id: String, p_player_id: String, p_type: BuildType, p_neighbor_tiles: Array[Vector3i]):
	id = p_id
	player_id = p_player_id
	type = p_type
	neighbor_tiles = p_neighbor_tiles

static func from_dict(dict: Dictionary) -> SettlementLocation:
	var neighbor_tiles: Array[Vector3i] = []
	neighbor_tiles.assign(dict["neighbor_tiles"].map(func(coord): return DictUtils.vector3i_from_dict(coord)))
	return SettlementLocation.new(dict["id"], dict["player_id"], BuildType.find_key(dict["type"]), neighbor_tiles)

func to_dict() -> Dictionary:
	return {
		"id": id,
		"player_id": player_id,
		"type": type,
		"neighbor_tiles": neighbor_tiles.map(func(coord): return DictUtils.vector3i_to_dict(coord))
	}
