class_name PlayerResources
extends RefCounted

signal resource_changed(resource: PlayerResource, amount: int)
	
var resources: Dictionary = {}

func init_resource(resource: PlayerResource) -> void:
	resources[resource] = 0

func get_resource_count(resource: PlayerResource) -> int:
	return resources[resource]

func add_resource(resource: PlayerResource, amount: int) -> void:
	resources[resource] += amount
	resource_changed.emit(resource, amount)
	
func remove_resource(resource: PlayerResource, amount: int) -> void:
	assert(resources[resource] > amount)
	resources[resource] -= amount
	resource_changed.emit(resource, -amount)

func get_resource_keys() -> Array[PlayerResource]:
	var player_resources: Array[PlayerResource] = []
	player_resources.assign(resources.keys())
	return player_resources
