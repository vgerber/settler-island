class_name PlayerSummary
extends RefCounted

var player_id: String
var name: String = "PlayerName"
var card_count: int = 0
var longest_road_count: int = 0
var victory_points: int = 0
var color: Color = Color(0, 0, 0)

static func from_dict(summary_dict: Dictionary) -> PlayerSummary:
	var summary = PlayerSummary.new()
	summary.player_id = summary_dict["player_id"]
	summary.name = summary_dict["name"]
	summary.card_count = summary_dict["card_count"]
	summary.victory_points = summary_dict["victory_points"]
	summary.longest_road_count = summary_dict["longest_road_count"]
	var color_array = summary_dict["color"]
	summary.color.r = color_array[0]
	summary.color.g = color_array[1]
	summary.color.b = color_array[2]
	return summary
	
static func from_player(player: Player):
	pass

func to_dict() -> Dictionary:
	var summary: Dictionary = {}
	summary["player_id"] = player_id
	summary["name"] = name
	summary["card_count"] = card_count
	summary["victory_points"] = victory_points
	summary["longest_road_count"] = longest_road_count
	summary["color"] = [0.0, 0.0, 0.0]
	summary["color"][0] = color.r
	summary["color"][1] = color.g
	summary["color"][2] = color.b
	return summary
