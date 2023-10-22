class_name Player
extends RefCounted

var resources: PlayerResources

func _init():
	resources = PlayerResources.new()

func get_prestiege() -> int:
	return 0

func get_color() -> Color:
	return Color(0.7, 0.2, 0.2)
