class_name SheepResource
extends PlayerResource

static func get_id() -> String:
	return "SheepResource"

func get_name() -> String:
	return tr("Sheep")

func get_icon() -> Texture2D:
	return load("res://icon.svg")
