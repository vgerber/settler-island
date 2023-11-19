class_name BaseResources
extends PlayerResources

var city_pieces: int = 4
var village_pieces: int = 5
var road_pieces: int = 15

func _init(resource_ids: Array[String], cities = 4, villages = 5, roads = 15):
	city_pieces = cities
	village_pieces = villages
	road_pieces = roads
	
	for resource_id in resource_ids:
		init_resource(resource_id)

static func from_dict(dict: Dictionary) -> BaseResources:
	var dict_resources: Array[PlayerResource] = []
	return BaseResources.new(dict["resources"], dict["city_pieces"], dict["village_pieces"], dict["road_pieces"])

func to_dict() -> Dictionary:
	return { 
		"city_pieces": city_pieces,
		"village_pieces": village_pieces,
		"road_pieces": road_pieces,
		"resources": resources
	}

static func resource_from_dict(dict: Dictionary) -> PlayerResource:
	return get_resource_mappings()[dict["id"]]

static func get_resource_mappings() -> Dictionary:
	var mappings = {}
	mappings[WoodResource.get_id()] = WoodResource.new()
	mappings[ClayResource.get_id()] = ClayResource.new()
	mappings[SheepResource.get_id()] = SheepResource.new()
	mappings[OreResource.get_id()] = OreResource.new()
	mappings[WheatResource.get_id()] = WheatResource.new()
	return mappings
