class_name RobberLocation
extends RefCounted

var assigned_tile_id: String

func _init(p_assigned_tile_id: String):
	assigned_tile_id = p_assigned_tile_id

static func from_dict(dict: Dictionary) -> RobberLocation:
	return RobberLocation.new(dict["assigned_tile_id"])

func to_dict() -> Dictionary:
	return { "assigned_tile_id": assigned_tile_id }
