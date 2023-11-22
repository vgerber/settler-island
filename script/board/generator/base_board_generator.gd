class_name BaseBoardGenerator
extends RefCounted

const BOARD_SIZE: int = 3

var board_resources: Array[PlayerResource] = [
	WoodResource.new(),
	ClayResource.new(),
	OreResource.new(),
	WheatResource.new(),
	SheepResource.new()
]

func generate_board() -> GameBoard:
	var hexagon_map = generate_hexagon_map()
	return GameBoard.new(hexagon_map, generate_settlement_map(hexagon_map), generate_dice_chips(hexagon_map), get_robber_location(hexagon_map))

func generate_hexagon_map() -> HexagonMap:
	var hexagon_map = HexagonMap.new()
	var resource_list = []
	var resource_counts = [4, 3, 3, 4, 4]
	for resource_count_index in range(resource_counts.size()):
		var resource = board_resources[resource_count_index]
		for resource_counter in range(resource_counts[resource_count_index]):
			resource_list.append(resource.get_id())
	resource_list.shuffle()
	
	for q in range(-(BOARD_SIZE-1), BOARD_SIZE):
		for r in range(-(BOARD_SIZE-1), BOARD_SIZE):
			var s = clamp(-q - r, -(BOARD_SIZE - 1), (BOARD_SIZE - 1))
			if (q + r + s) != 0:
				continue
			var coordinates = Vector3i(q, r, s)
			if q == 0 and r == 0 and s == 0:
				hexagon_map.add_tile(FillerTile.new(coordinates))
			else:
				hexagon_map.add_tile(ResourceTile.new(coordinates, [], resource_list.pop_back()))
	return hexagon_map
	
func generate_dice_chips(hexagon_map: HexagonMap) -> Array[DiceChipLocation]:
	var chips: Array[DiceChipLocation] = []
	var chip_values: Array[int] = [1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 12]
	chip_values.shuffle()
	for tile in hexagon_map.tiles:
		if tile is ResourceTile:
			chips.push_back(DiceChipLocation.new(tile.get_id(), chip_values.pop_back()))
	return chips

func generate_settlement_map(hexagon_map: HexagonMap) -> SettlementMap:
	var settlement_map = SettlementMap.new()
	for q in range(-(BOARD_SIZE - 1), BOARD_SIZE):
		for r in range(-(BOARD_SIZE - 1), BOARD_SIZE):
			var coordinates = Hexagon.get_coordinates_from_qr(q, r)
			if not is_coordinate_in_base_map(coordinates):
				continue
			var tile = hexagon_map.get_tile(coordinates)
			if not tile is ResourceTile:
				continue
				
			tile = tile as ResourceTile
			var neighbors: Array[Vector3i] = Hexagon.get_neighbor_coordinates(tile.cube_coordinates)
			var corner_locations: Array[SettlementLocation] = []
			for neighbor_index in range(neighbors.size()):
				# neighbors are ordered clockwise/counter clockwise
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
				
				var settlement = SettlementLocation.new(settlement_id, "", SettlementLocation.BuildType.NONE, [tile.cube_coordinates, neighbor1, neighbor2])
				corner_locations.push_back(settlement)
				settlement_map.add_settlement(settlement)
				tile.assigned_settlements.push_back(settlement)
			
			for corner_location_index in range(corner_locations.size()):
				var corner_a = corner_locations[corner_location_index]
				var corner_b = corner_locations[(corner_location_index + 1) % corner_locations.size()]
				var road_id_a = corner_a.name + " - " + corner_b.nam
				var road_id_b = corner_b.name + " - " + corner_a.nam
				if settlement_map.has_road(road_id_a) or settlement_map.has_road(road_id_b):
					continue
				settlement_map.add_road(RoadLocation.new(road_id_a, corner_a.id, corner_b.id, "", false))
	return settlement_map

func get_robber_location(hexagon_map: HexagonMap) -> RobberLocation:
	return RobberLocation.new(hexagon_map.get_tile(Vector3i(0, 0, 0)).get_id())

func is_coordinate_in_base_map(coordinate: Vector3i) -> bool:
	return abs(coordinate.x) < BOARD_SIZE and abs(coordinate.y) < BOARD_SIZE and abs(coordinate.z) < BOARD_SIZE
