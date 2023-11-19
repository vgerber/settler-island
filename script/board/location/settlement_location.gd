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
var location: String

func _init(p_id: String, p_player_id: String, p_type: BuildType, p_location: String):
	id = p_id
	player_id = p_player_id
	type = p_type
	location = p_location

static func from_dict(dict: Dictionary) -> SettlementLocation:
	return SettlementLocation.new(dict["id"], dict["player_id"], BuildType.find_key(dict["type"]), dict["location"])

func to_dict() -> Dictionary:
	return {
		"id": id,
		"player_id": player_id,
		"type": type,
		"location": location
	}
