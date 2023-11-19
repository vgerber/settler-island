class_name RoadLocation

var id: String
var settlement_id_a: String
var settlement_id_b: String
var player_id: String


var build: bool = false

func _init(p_id: String, p_settlement_id_a: String, p_settlement_id_b: String, p_player_id: String, p_build: bool):
	id = p_id
	settlement_id_a = p_settlement_id_a
	settlement_id_b = p_settlement_id_b
	player_id = p_player_id
	build = p_build

static func from_dict(dict: Dictionary) -> RoadLocation:
	return RoadLocation.new(
		dict["id"],
		dict["settlement_id_a"],
		dict["settlement_id_b"],
		dict["player_id"],
		bool(dict["build"])
	)

func to_dict() -> Dictionary:
	return {
		"id": id,
		"settlement_id_a": settlement_id_a,
		"settlement_id_b": settlement_id_b,
		"player_id": player_id,
		"build": int(build)
	}
