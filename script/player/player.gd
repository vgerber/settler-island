class_name Player
extends RefCounted

signal changed()

var id: String
var user_id: String
var resources: PlayerResources
var color: Color

func _init(p_id: String, p_user_id: String, p_resources: PlayerResources, p_color: Color):
	id = p_id
	user_id = p_user_id
	resources = p_resources
	resources.resource_changed.connect(func(resource: PlayerResource, amount: int): changed.emit())
	color = p_color

func get_color() -> Color:
	return color

static func from_dict(dict: Dictionary) -> Player:
	var color_array = dict["color"]
	return Player.new(
		dict["id"],
		dict["user_id"], 
		BaseResources.new(dict["resources"]),
		Color(color_array[0], color_array[1], color_array[2])
	)

func to_dict() -> Dictionary:
	var player: Dictionary = {}
	player["id"] = id
	player["user_id"] = user_id
	player["resources"] = (resources as BaseResources).to_dict()
	player["color"] = [0.0, 0.0, 0.0]
	player["color"][0] = color.r
	player["color"][1] = color.g
	player["color"][2] = color.b
	return player

