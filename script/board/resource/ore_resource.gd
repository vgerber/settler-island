class_name OreResource
extends PlayerResource

static func get_id() -> String:
	return "OreResource"

func get_name() -> String:
	return tr("Ore")

func get_icon() -> Texture2D:
	return load("res://icon.svg")
