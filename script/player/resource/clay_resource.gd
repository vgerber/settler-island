class_name ClayResource
extends PlayerResource

static func get_id() -> String:
	return "ClayResource"

func get_name() -> String:
	return tr("Clay")

func get_icon() -> Texture2D:
	return load("res://icon.svg")
