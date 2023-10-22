class_name PlayerResources
extends RefCounted

enum BaseResource {
	WOOD,
	ORE,
	CLAY,
	WHOOL,
	WHEAT
}
	
var resources: Dictionary = {}

func _init():
	for type in BaseResource.values():
		resources[type] = 0

func get_resource_count(type: BaseResource) -> int:
	return resources[type]

func add_resource(type: BaseResource, amount: int) -> void:
	resources[type] += amount
	
func remove_resource(type: BaseResource, amount: int) -> void:
	assert(resources[type] > amount)
	resources[type] -= amount
