class_name Player
extends RefCounted

signal changed()

var resources: PlayerResources

func _init(p_resources: PlayerResources):
	resources = p_resources
	resources.resource_changed.connect(func(resource: PlayerResource, amount: int): changed.emit())

func get_prestiege() -> int:
	return 0

func get_color() -> Color:
	return Color(0.7, 0.2, 0.2)
