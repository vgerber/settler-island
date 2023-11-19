class_name WoodResource
extends PlayerResource

static func get_id() -> String:
	return "WoodResource"

func get_name() -> String:
	return tr("Wood")

func get_icon() -> Texture2D:
	return load("res://icon.svg")
