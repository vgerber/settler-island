class_name GameScene
extends Node

signal current_player_changed

@onready var board: BoardScene = $Board
@onready var board_hud: BoardHUD = $BoardHUD

var players: Array[PlayerSummary]
var current_player_index = 0:
	set(index):
		current_player_index = index
		current_player_changed.emit()
var game_state: GameState
var session_player: Player


func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	board_hud.game = self
	
	game_state = GameState.new(self)
	game_state.set_current_action(game_state.get_action(StartVillagePlacementAction.get_id()))
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_game(game_summary: GameSummary) -> void:
	players = game_summary.players
	board_hud.set_players(players)
	current_player_index = game_summary.current_player_index
	game_state.set_current_action(game_state.get_action(game_summary.game_state_id))
	board.generate_board(game_summary.board)

func roll_dice() -> Array[int]:
	return [randi_range(1, 6), randi_range(1, 6)]

func get_resources() -> Array[PlayerResource]:
	return board.board_resources

func get_next_player_index(player_index: int) -> int:
	return (player_index + 1) % players.size()

func is_player_turn(player: Player) -> bool:
	return true or player == players[current_player_index]

func get_current_player() -> PlayerSummary:
	return players[current_player_index]

func get_possible_settlement_locations(player: Player) -> Array[SettlementLocation]:
	var map: SettlementMap = board.settlement_map
	var settlement_count = map.get_player_settlements(player).size()
	var possible_settlements: Array[SettlementLocation] = []
	var settlement_filter = func(settlement: SettlementLocation):
		if settlement_count < 2:
			return true
		return map.has_location_player_road(settlement, player)
	return map.get_interactable_settlement_locations(player).filter(settlement_filter)

func get_player_summary(player: Player) -> PlayerSummary:
	var summary = PlayerSummary.new()
	summary.victory_points = get_player_victory_points(player)
	for resource in player.resources.get_resource_keys():
		summary.card_count = player.resources.get_resource_count(resource)
	summary.color = player.get_color()
	return summary

func get_player_victory_points(player: Player) -> int:
	return board.settlement_map.get_player_villages(player).size() + board.settlement_map.get_player_cities(player).size() * 2

func set_session_player(p_session_player: Player) -> void:
	session_player = p_session_player
	board_hud.set_player(session_player)
