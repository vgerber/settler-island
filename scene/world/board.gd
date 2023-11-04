class_name Board
extends Node3D

@onready var map: HexagonMap = $HexagonMap
@onready var settlement_map: SettlementMap = $SettlementMap
@onready var camera: Camera3D = $Camera



var base_map_size: int = 3
var dice_value_chips: Node3D = Node3D.new()

var board_resources: Array[PlayerResource] = [
	WoodResource.new(),
	ClayResource.new(),
	OreResource.new(),
	WheatResource.new(),
	SheepResource.new()
]

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(dice_value_chips)
	
	randomize()
	generate_base_resources()
	place_base_settlement_locations()
	place_value_chips()
	camera.position = map.position + Vector3(0, 40, 20)
	camera.look_at(map.position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func generate_base_resources() -> void:
	var resource_list = []
	var resource_colors = {
		board_resources[0]: Color(0.1, 0.6, 0.05), 
		board_resources[1]: Color(0.5, 0.2, 0.0), 
		board_resources[2]: Color(0.4, 0.4, 0.4),
		board_resources[3]: Color(0.6, 0.6, 0.0), 
		board_resources[4]: Color(0.3, 0.9, 0.3)
	}
	var resource_counts = [4, 3, 3, 4, 4]
	for resource_count_index in range(resource_counts.size()):
		var resource = board_resources[resource_count_index]
		for resource_counter in range(resource_counts[resource_count_index]):
			resource_list.append(resource)
	resource_list.shuffle()
	
	var chip_values: Array[int] = [1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 12]
	chip_values.shuffle()
	
	for q in range(-(base_map_size-1), base_map_size):
		for r in range(-(base_map_size-1), base_map_size):
			var s = clamp(-q - r, -(base_map_size - 1), (base_map_size - 1))
			if (q + r + s) != 0:
				continue
			var tile: HexagonTile = null
			if q == 0 and r == 0 and s == 0:
				tile = preload("res://scene/world/map/hexagon/filler_tile.tscn").instantiate() as FillerTile
				tile.set_debug_color(Color(0.9, 0.9, 0.2))
			else:
				tile = preload("res://scene/world/map/hexagon/resource_tile.tscn").instantiate() as ResourceTile
				tile.resource_type = resource_list.pop_back()
				tile.set_debug_color(resource_colors[tile.resource_type])
			tile.cube_coordinates = Vector3i(q, r, s)
			tile.name = "HexagonTile %s,%s,%s" % [q, r, s]
			map.add_tile(tile)
			
			if tile is ResourceTile:
				var chip = preload("res://scene/world/map/tile_value_chip.tscn").instantiate() as TileValueChip
				chip.position = tile.position + Vector3(0, 1, 0)
				chip.assigned_tile = tile
				chip.set_value(chip_values.pop_front())
				dice_value_chips.add_child(chip)

func place_base_settlement_locations() -> void:
	for q in range(-(base_map_size - 1), base_map_size):
		for r in range(-(base_map_size - 1), base_map_size):
			var coordinates = map.get_coordinates_from_qr(q, r)
			if not is_coordinate_in_base_map(coordinates):
				continue
			var tile = map.get_tile(coordinates)
			if not tile is ResourceTile:
				continue
				
			tile = tile as ResourceTile
			var neighbors = map.get_tile_neighbor_coordinates(tile)
			var corner_locations: Array[SettlementLocation] = []
			for neighbor_index in range(neighbors.size()):
				var neighbor1 = neighbors[neighbor_index]
				var neighbor2 = neighbors[(neighbor_index + 1) % neighbors.size()]
				
				var settlement_id = "%s,%s,%s - %s,%s,%s" % [
					min(q, neighbor1.x, neighbor2.x), 
					min(r, neighbor1.y, neighbor2.y),
					min(-q-r, neighbor1.z, neighbor2.z), 
					max(q, neighbor1.x, neighbor2.x), 
					max(r, neighbor1.y, neighbor2.y),
					max(-q-r, neighbor1.z, neighbor2.z)]
				
				
				if settlement_map.settlements.has(settlement_id):
					var settlement: SettlementLocation = settlement_map.settlements[settlement_id]
					tile.assigned_settlements.push_back(settlement)
					corner_locations.push_back(settlement)
					continue
				
				var settlement = preload("res://scene/world/map/location/settlement_location.tscn").instantiate() as SettlementLocation
				
				var pos1 = tile.position
				var pos2 = map.coordinates_to_position(neighbor1, Vector2(tile.width, tile.height))
				var pos3 = map.coordinates_to_position(neighbor2, Vector2(tile.width, tile.height))
				settlement.position = (pos1 + pos2 + pos3) / 3 + Vector3(0, 1, 0)
				settlement.set_id(settlement_id)
				corner_locations.push_back(settlement)
				settlement_map.add_settlement(settlement)
				tile.assigned_settlements.push_back(settlement)
			
			for corner_location_index in range(corner_locations.size()):
				var corner_a = corner_locations[corner_location_index]
				var corner_b = corner_locations[(corner_location_index + 1) % corner_locations.size()]
				if (corner_a.name + " - " + corner_b.name) in settlement_map.roads or (corner_b.name + " - " + corner_a.name) in settlement_map.roads:
					continue
				var edge_id = corner_a.name + " - " + corner_b.name
				var mesh = preload("res://scene/world/map/location/road_location.tscn").instantiate() as RoadLocation
				mesh.set_id(edge_id)
				mesh.settlement_a = corner_a
				mesh.settlement_b = corner_b
				settlement_map.add_road(mesh)
				
				mesh.position = (corner_a.position + corner_b.position) / 2
				mesh.look_at(corner_a.position)

func place_value_chips() -> void:
	for q in range(-(base_map_size - 1), base_map_size):
		for r in range(-(base_map_size - 1), base_map_size):
			var coordinates = map.get_coordinates_from_qr(q, r)
			if not is_coordinate_in_base_map(coordinates):
				continue
			var tile = map.get_tile(coordinates)
			if not tile is ResourceTile:
				continue

func get_tiles_for_chip_value(value: int) -> Array[ResourceTile]:
	var tiles: Array[ResourceTile] = []
	for chip in (dice_value_chips.get_children() as Array[TileValueChip]):
		if chip.value == value:
			tiles.push_back(chip.assigned_tile)
	return tiles

func is_coordinate_in_base_map(coordinate: Vector3i) -> bool:
	return abs(coordinate.x) < base_map_size and abs(coordinate.y) < base_map_size and abs(coordinate.z) < base_map_size
