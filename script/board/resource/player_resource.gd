class_name PlayerResource
extends RefCounted

static func get_id() -> String:
	return "PlayerResource"

func get_name() -> String:
	return "PlayerResource"

func get_icon() -> Texture2D:
	return load("res://icon.svg")

func to_dict() -> Dictionary:
	return { "id": get_id() }
