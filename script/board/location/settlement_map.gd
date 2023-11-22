class_name SettlementMap
extends RefCounted

var settlements: Dictionary = {} 
var roads: Dictionary = {}
var settlements_connections: Dictionary = {}

static func from_dict(dict: Dictionary) -> SettlementMap:
	var map = SettlementMap.new()
	for settlement_dict in dict["settlements"]:
		var settlement = SettlementLocation.from_dict(settlement_dict)
		map.settlements[settlement.id] = settlement
	for road_dict in dict["roads"]:
		var road = RoadLocation.from_dict(road_dict)
		map.roads[road.id] = road
	map.settlements_connections = dict["settlment_connections"]
	return map

func to_dict() -> Dictionary:
	return {
		"settlements": settlements.values().map(func(settlement: SettlementLocation): return settlement.to_dict()),
		"roads": roads.values().map(func(road: RoadLocation): return road.to_dict()),
		"settlements_connections": settlements_connections
	}

func has_road(road_id: String) -> bool:
	return roads.has(road_id)

func add_road(road: RoadLocation) -> void:
	roads[road.id] = road
	if not settlements_connections.has(road.settlement_a.id):
		settlements_connections[road.settlement_a.id] = []
	if not settlements_connections.has(road.settlement_b.id):
		settlements_connections[road.settlement_b.id] = []
		
	settlements_connections[road.settlement_a.id].push_back(road.id)
	settlements_connections[road.settlement_b.id].push_back(road.id)

func has_settlement(settlement_id: String) -> bool:
	return settlements.has(settlement_id)

func add_settlement(settlement: SettlementLocation) -> void:
	settlements[settlement.id] = settlement

func get_neighbor_settlements(settlement_id: String) -> Array[SettlementLocation]:
	var neighbors: Array[SettlementLocation] = []
	for road in settlements_connections[settlement_id]:
		road = road as RoadLocation
		if road.settlement_a_id == settlement_id:
			neighbors.push_back(road.settlement_b)
		else:
			neighbors.push_back(road.settlement_a)
	return neighbors
	
func get_road_locations(settlement_id: String) -> Array[RoadLocation]:
	var roads: Array[RoadLocation] = []
	roads.assign(settlements_connections[settlement_id])
	return roads


func get_interactable_settlement_locations(player_id: String) -> Array[SettlementLocation]:
	var interactable_settlement_locations: Array[SettlementLocation] = []
	for settlement in get_settlements():
		if settlement.is_city():
			continue
		if settlement.player_id != null and settlement.player_id != player_id:
			continue
			
		var can_build = true
		for neighbor in get_neighbor_settlements(settlement.id):
			if neighbor.is_village() or neighbor.is_city():
				can_build = false
				break
		if can_build:
			interactable_settlement_locations.push_back(settlement)
	return interactable_settlement_locations
	
func has_location_player_road(settlement_id: String, player_id: String) -> bool:
	for location in settlements_connections[settlement_id]:
		location = location as RoadLocation
		if location.build and location.player_id == player_id:
			return true
	return false

func get_player_settlements(player_id: String) -> Array[SettlementLocation]:
	return get_settlements().filter(func(settlement: SettlementLocation): return settlement.player_id == player_id)
	
func get_player_villages(player_id: String) -> Array[SettlementLocation]:
	var villages: Array[SettlementLocation] = []
	villages.assign(get_player_settlements(player_id).filter(func(settlement: SettlementLocation): return settlement.type == SettlementLocation.BuildType.VILLAGE))
	return villages

func get_player_cities(player_id: String) -> Array[SettlementLocation]:
	var cities: Array[SettlementLocation] = []
	cities.assign(get_player_settlements(player_id).filter(func(settlement: SettlementLocation): return settlement.type == SettlementLocation.BuildType.CITY))
	return cities

func get_player_roads(player_id: String) -> Array[RoadLocation]:
	return get_roads().filter(func(road: RoadLocation): return road.player_id == player_id)

func get_settlements() -> Array[SettlementLocation]:
	var settlements_array: Array[SettlementLocation] = []
	settlements_array.assign(settlements.values())
	return settlements_array
	
func get_roads() -> Array[RoadLocation]:
	var roads_array: Array[RoadLocation] = []
	roads_array.assign(roads.values())
	return roads_array

func get_interactable_road_locations(player_id: String) -> Array[RoadLocation]:
	var road_filter = func(location: RoadLocation):
		if location.has_road():
			return false
		if location.settlement_a.player_id == player_id or location.settlement_b.player_id == player_id:
			return true
		return has_location_player_road(location.settlement_a, player_id) or has_location_player_road(location.settlement_b, player_id)
			
	return get_roads().filter(road_filter)

func get_possible_settlement_locations(player_id: String) -> Array[SettlementLocation]:
	var settlement_count = get_player_settlements(player_id).size()
	var possible_settlements: Array[SettlementLocation] = []
	var settlement_filter = func(settlement: SettlementLocation):
		if settlement_count < 2:
			return true
		return has_location_player_road(settlement.id, player_id)
	return get_interactable_settlement_locations(player_id).filter(settlement_filter)
