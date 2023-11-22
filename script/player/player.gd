class_name Player
extends RefCounted

signal changed()

var id: String
var user: User
var resources: PlayerResources
var color: Color

func _init(p_id: String, p_user: User, p_resources: PlayerResources, p_color: Color):
	id = p_id
	user = p_user
	resources = p_resources
	resources.resource_changed.connect(func(resource: String, amount: int): changed.emit())
	color = p_color

func get_color() -> Color:
	return color

static func from_dict(dict: Dictionary) -> Player:
	return Player.new(
		dict["id"],
		User.from_dict(dict["user"]), 
		BaseResources.new(dict["resources"]),
		DictUtils.color_from_dict(dict["color"])
	)

func to_dict() -> Dictionary:
	var player: Dictionary = {}
	player["id"] = id
	player["user"] = user.to_dict()
	player["resources"] = (resources as BaseResources).to_dict()
	player["color"] = DictUtils.color_to_dict(color)
	return player

