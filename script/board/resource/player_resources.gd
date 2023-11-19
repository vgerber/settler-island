class_name PlayerResources
extends RefCounted

signal resource_changed(resource_id: String, amount: int)
	
var resources: Dictionary = {}

func init_resource(resource_id: String) -> void:
	resources[resource_id] = 0

func get_resource_count(resource_id: String) -> int:
	return resources[resource_id]

func add_resource(resource_id: String, amount: int) -> void:
	resources[resource_id] += amount
	resource_changed.emit(resource_id, amount)
	
func remove_resource(resource_id: String, amount: int) -> void:
	assert(resources[resource_id] > amount)
	resources[resource_id] -= amount
	resource_changed.emit(resource_id, -amount)

func get_resource_keys() -> Array[String]:
	var player_resources: Array[String] = []
	player_resources.assign(resources.keys())
	return player_resources

