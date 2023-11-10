class_name Game
extends Node

@onready var board: Board = $Board
@onready var board_hud: BoardHUD = $BoardHUD

var players: Array[Player]
var current_player_index = 0
var game_state: GameState

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	board_hud.game = self
	for player_index in range(4):
		players.push_back(Player.new(BaseResources.new(get_resources())))
	board_hud.set_player(players[0])
	GameUserSession.player = players[0]
	GameUserSession.game = self
	board.settlement_map.changed.connect(update_build_locations)
	update_build_locations()
	
	game_state = GameState.new(self)
	game_state.set_current_action(game_state.get_action(RollDiceAction.get_id()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_dice() -> Array[int]:
	return [randi_range(1, 6), randi_range(1, 6)]

func get_resources() -> Array[PlayerResource]:
	return board.board_resources

func is_player_turn(player: Player) -> bool:
	return player == players[current_player_index]
	
func end_turn(player: Player) -> void:
	if not is_player_turn(player):
		return
	current_player_index = (current_player_index + 1) % players.size()

func get_possible_settlement_locations(player: Player) -> Array[SettlementLocation]:
	var map: SettlementMap = board.settlement_map
	var settlement_count = map.get_player_settlements(player).size()
	var possible_settlements: Array[SettlementLocation] = []
	var settlement_filter = func(settlement: SettlementLocation):
		if settlement_count < 2:
			return true
		return map.has_location_player_road(settlement, player)
	return map.get_interactable_settlement_locations(player).filter(settlement_filter)

func get_possible_road_locations(player: Player) -> Array[RoadLocation]:
	return board.settlement_map.get_interactable_road_locations(player)

func update_build_locations():
	var map: SettlementMap = board.settlement_map
	for road in map.get_roads():
		road.set_clickable(false)
	for settlement in map.get_settlements():
		settlement.set_clickable(false)
	for road in get_possible_road_locations(GameUserSession.player):
		road.set_clickable(true)
	for settlement in get_possible_settlement_locations(GameUserSession.player):
		settlement.set_clickable(true)
