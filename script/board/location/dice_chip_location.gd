class_name DiceChipLocation
extends RefCounted

var assigned_tile_id: String
var dice_value: int

func _init(p_assigned_tile_id: String, p_dice_value: int):
	assigned_tile_id = p_assigned_tile_id
	dice_value = p_dice_value

static func from_dict(dict: Dictionary) -> DiceChipLocation:
	return DiceChipLocation.new(dict["assigned_tile_id"], dict["dice_value"])

func to_dict() -> Dictionary:
	return { "assigned_tile_id": assigned_tile_id, "dice_value": dice_value }
