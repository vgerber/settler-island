class_name BoardScene
extends Node3D

@onready var map: HexagonMapScene = $HexagonMap
@onready var settlement_map: SettlementMapScene = $SettlementMap
@onready var camera: Camera3D = $Camera
@onready var robber: RobberLocationScene = $RobberLocation
@onready var dice_value_chips: Node3D = $HexagonMap/DiceChips

var base_map_size: int = 3

var robber_tiles: Array[HexagonTile] = []

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
	camera.position = map.position + Vector3(0, 40, 20)
	camera.look_at(map.position)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func generate_board(board: GameBoard) -> void:
	generate_tiles(board.tile_map)
	generate_dice_chips(board.dice_chips)
	generate_settlement_map(board.settlement_map)
	robber.assign_tile(map.get_tile_by_id(board.robber.assigned_tile_id))

func generate_tiles(hexagon_map: HexagonMap) -> void:
	var resource_colors = {
		WoodResource.get_id(): Color(0.1, 0.6, 0.05), 
		ClayResource.get_id(): Color(0.5, 0.2, 0.0), 
		OreResource.get_id(): Color(0.4, 0.4, 0.4),
		WheatResource.get_id(): Color(0.6, 0.6, 0.0), 
		SheepResource.get_id(): Color(0.3, 0.9, 0.3)
	}
	
	for tile in hexagon_map.tiles:
		var tile_scene: HexagonTileScene = null
		if tile is FillerTile:
			tile_scene = preload("res://scene/world/map/hexagon/filler_tile.tscn").instantiate() as FillerTileScene
			tile_scene.set_debug_color(Color(0.9, 0.9, 0.2))
		else:
			tile_scene = preload("res://scene/world/map/hexagon/resource_tile.tscn").instantiate() as ResourceTileScene
			tile_scene.resource_id = (tile as ResourceTile).resource_id
			tile_scene.set_debug_color(resource_colors[tile_scene.resource_type])
		tile_scene.cube_coordinates = tile.cube_coordinates
		tile_scene.name = "%s" % tile.get_id()
		map.add_tile(tile_scene)
		robber_tiles.push_back(tile)

func generate_dice_chips(chips: Array[DiceChipLocation]) -> void:
	for chip in chips:
		var chip_scene = preload("res://scene/world/map/tile_value_chip.tscn").instantiate() as TileValueChip
		chip_scene.position = chip. tile.position + Vector3(0, 1, 0)
		chip_scene.assigned_tile = map.get_tile_by_id(chip.assigned_tile_id)
		chip_scene.set_value(chip.dice_value)
		dice_value_chips.add_child(chip_scene)

func generate_settlement_map(p_settlement_map: SettlementMap) -> void:
	for settlement in p_settlement_map.settlements.values():
		settlement = settlement as SettlementLocation
		var neightbors: Array[Vector3i] = settlement.neighbor_tiles
		var settlement_scene = preload("res://scene/world/map/location/settlement_location.tscn").instantiate() as SettlementLocationScene
		settlement_scene.set_id(settlement.id)
		var settlement_position = Vector3(0, 0, 0)
		for tile in settlement.neighbor_tiles.map(func(coord): return map.get_tile(coord)):
			settlement_position += tile.position
		settlement_scene.position = settlement_position / settlement.neighbor_tiles.size()
		match settlement.type:
			SettlementLocation.BuildType.NONE: settlement_scene.reset()
			SettlementLocation.BuildType.VILLAGE: settlement_scene.set_village(settlement.player_id)
			SettlementLocation.BuildType.CITY: settlement_scene.set_city(settlement.player_id)
		settlement_map.add_settlement(settlement_scene)
	
	for road in p_settlement_map.roads.values():
		road = road as RoadLocation
		var road_scene = preload("res://scene/world/map/location/road_location.tscn").instantiate() as RoadLocationScene
		road_scene.set_id(road.id)
		road_scene.settlement_a = settlement_map.settlements[road.settlement_id_a]
		road_scene.settlement_b = settlement_map.settlements[road.settlement_id_b]
		settlement_map.add_road(road_scene)
		
		road_scene.position = (road_scene.settlement_a.position + road_scene.settlement_b.position) / 2
		road_scene.look_at(road_scene.settlement_a.position)
