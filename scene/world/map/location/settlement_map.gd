class_name SettlementMap
extends Node3D

signal changed

var settlements: Dictionary = {} 
var roads: Dictionary = {}
var settlements_connections: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func add_road(road: RoadLocation) -> void:
	road.changed.connect(func(): changed.emit())
	add_child(road)
	roads[road.name] = road
	if not settlements_connections.has(road.settlement_a.name):
		settlements_connections[road.settlement_a.name] = []
	if not settlements_connections.has(road.settlement_b.name):
		settlements_connections[road.settlement_b.name] = []
		
	settlements_connections[road.settlement_a.name].push_back(road)
	settlements_connections[road.settlement_b.name].push_back(road)
	changed.emit()

func add_settlement(settlement: SettlementLocation) -> void:
	settlement.changed.connect(func(): changed.emit())
	add_child(settlement)
	settlements[settlement.name] = settlement
	changed.emit()

func get_neighbor_settlements(settlement: SettlementLocation) -> Array[SettlementLocation]:
	var neighbors: Array[SettlementLocation] = []
	for road in settlements_connections[settlement.name]:
		road = road as RoadLocation
		if road.settlement_a.name == settlement.name:
			neighbors.push_back(road.settlement_b)
		else:
			neighbors.push_back(road.settlement_a)
	return neighbors
	
func get_road_locations(settlement: SettlementLocation) -> Array[RoadLocation]:
	var roads: Array[RoadLocation] = []
	roads.assign(settlements_connections[settlement.name])
	return roads


func get_interactable_settlement_locations(player: Player) -> Array[SettlementLocation]:
	var interactable_settlement_locations: Array[SettlementLocation] = []
	for settlement in get_settlements():
		if settlement.is_city():
			continue
		if settlement.player != null and settlement.player != player:
			continue
			
		var can_build = true
		for neighbor in get_neighbor_settlements(settlement):
			if neighbor.is_village() or neighbor.is_city():
				can_build = false
				break
		if can_build:
			interactable_settlement_locations.push_back(settlement)
	return interactable_settlement_locations
	
func has_location_player_road(settlement: SettlementLocation, player: Player) -> bool:
	for location in settlements_connections[settlement.name]:
		location = location as RoadLocation
		if location.has_road() and location.player == player:
			return true
	return false

func get_player_settlements(player: Player) -> Array[SettlementLocation]:
	return get_settlements().filter(func(settlement: SettlementLocation): return settlement.player == player)
	
func get_player_roads(player: Player) -> Array[RoadLocation]:
	return get_roads().filter(func(road: RoadLocation): return road.player == player)

func get_settlements() -> Array[SettlementLocation]:
	var settlements_array: Array[SettlementLocation] = []
	settlements_array.assign(settlements.values())
	return settlements_array
	
func get_roads() -> Array[RoadLocation]:
	var roads_array: Array[RoadLocation] = []
	roads_array.assign(roads.values())
	return roads_array

func get_interactable_road_locations(player: Player) -> Array[RoadLocation]:
	var road_filter = func(location: RoadLocation):
		if location.has_road():
			return false
		if location.settlement_a.player == player or location.settlement_b.player == player:
			return true
		return has_location_player_road(location.settlement_a, player) or has_location_player_road(location.settlement_b, player)
			
	return get_roads().filter(road_filter)
