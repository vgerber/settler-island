class_name SettlementMap
extends Node3D

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
	add_child(road)
	roads[road.name] = road
	if not settlements_connections.has(road.settlement_a.name):
		settlements_connections[road.settlement_a.name] = []
	if not settlements_connections.has(road.settlement_b.name):
		settlements_connections[road.settlement_b.name] = []
		
	settlements_connections[road.settlement_a.name].push_back(road)
	settlements_connections[road.settlement_b.name].push_back(road)

func add_settlement(settlement: SettlementLocation) -> void:
	add_child(settlement)
	settlements[settlement.name] = settlement
