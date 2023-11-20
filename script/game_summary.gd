class_name GameSummary
extends RefCounted

var board: GameBoard
var players: Array[PlayerSummary]
var current_player_index = 0
var game_state_id: String = "Init"

func _init(p_board: GameBoard, p_players: Array[PlayerSummary], p_current_player_index: int, p_game_state_id: String):
	board = p_board
	players = p_players	
	current_player_index = p_current_player_index
	game_state_id = p_game_state_id

static func from_dict(dict: Dictionary) -> GameSummary:
	var players: Array[PlayerSummary] = []
	players.assign(dict["players"].map(func(player): return PlayerSummary.from_dict(player)))
	return GameSummary.new(GameBoard.from_dict(dict["board"]), players, dict["current_player_index"], dict["game_state_id"])

func to_dict() -> Dictionary:
	return {
		"board": board.to_dict(),
		"players": players.map(func(player): return player.to_dict()),
		"current_player_index": current_player_index,
		"game_state_id": game_state_id
	}

func get_resources() -> Array[PlayerResource]:
	return board.board_resources

func get_next_player_index(player_index: int) -> int:
	return (player_index + 1) % players.size()

func is_player_turn(player: Player) -> bool:
	return true or player == players[current_player_index]

func get_current_player() -> PlayerSummary:
	return players[current_player_index]

