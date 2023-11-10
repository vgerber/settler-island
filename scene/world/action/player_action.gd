class_name PlayerAction
extends RefCounted

signal started
signal finished(next_action: String)
signal context_changed

var game: Game
var board: Board
var hud: BoardHUD

static func get_id() -> String:
	return "PlayerAction"

func start() -> void:
	started.emit()
	
func finish(next_action: String) -> void:
	finished.emit(next_action)

func set_context(p_game: Game, p_board: Board) -> void:
	game = p_game
	board = p_board
	hud = p_game.board_hud
	context_changed.emit()
