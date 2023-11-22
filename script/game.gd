class_name Game
extends Node

signal current_player_changed

var board: GameBoard
var players: Array[Player]
var current_player_index = 0:
	set(index):
		current_player_index = index
		current_player_changed.emit()
var game_state: GameState

func _init(p_board: GameBoard, p_players: Array[Player]):
	board = p_board
	players = p_players
	game_state = GameState.new(self)
	game_state.set_current_action(game_state.get_action(StartVillagePlacementAction.get_id()))

func to_summary() -> GameSummary:
	var player_summaries: Array[PlayerSummary] = []
	player_summaries.assign(players.map(func(player): get_player_summary(player)))
	return GameSummary.new(board, player_summaries, current_player_index, game_state.current_action.get_id())

func roll_dice() -> Array[int]:
	return [randi_range(1, 6), randi_range(1, 6)]

func get_resources() -> Array[String]:
	return board.board_resources

func get_next_player_index(player_index: int) -> int:
	return (player_index + 1) % players.size()

func is_player_turn(player: Player) -> bool:
	return true or player == players[current_player_index]

func get_current_player() -> Player:
	return players[current_player_index]

func get_possible_settlement_locations(player_id: String) -> Array[SettlementLocation]:
	var map: SettlementMap = board.settlement_map
	var settlement_count = map.get_player_settlements(player_id).size()
	var possible_settlements: Array[SettlementLocation] = []
	var settlement_filter = func(settlement: SettlementLocation):
		if settlement_count < 2:
			return true
		return map.has_location_player_road(settlement.id, player_id)
	return map.get_interactable_settlement_locations(player_id).filter(settlement_filter)

func get_player_summary(player: Player) -> PlayerSummary:
	var summary = PlayerSummary.new()
	summary.victory_points = get_player_victory_points(player)
	for resource in player.resources.get_resource_keys():
		summary.card_count = player.resources.get_resource_count(resource)
	summary.color = player.get_color()
	return summary

func get_player_victory_points(player: Player) -> int:
	return board.settlement_map.get_player_villages(player.id).size() + board.settlement_map.get_player_cities(player.id).size() * 2
