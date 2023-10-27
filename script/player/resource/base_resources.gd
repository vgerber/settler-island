class_name BaseResources
extends PlayerResources


var city_pieces: int = 4
var village_pieces: int = 5
var road_pieces: int = 15

func _init(resources: Array[PlayerResource], cities = 4, villages = 5, roads = 15):
	city_pieces = cities
	village_pieces = villages
	road_pieces = roads
	
	for resource in resources:
		init_resource(resource)
