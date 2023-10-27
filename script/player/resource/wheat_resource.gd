class_name WheatResource
extends PlayerResource

static func get_id() -> String:
	return "WheatResource"

func get_name() -> String:
	return tr("Wheat")

func get_icon() -> Texture2D:
	return load("res://icon.svg")
