class_name PlayerAction
extends RefCounted

signal started
signal finished(next_action: String)
signal context_changed

var game: GameScene
var board: GameBoard
var hud: BoardHUD

var _active: bool = false

static func get_id() -> String:
	return "PlayerAction"

func start() -> void:
	_active = true
	started.emit()
	
	
func finish(next_action: String) -> void:
	_active = false
	finished.emit(next_action)

func set_context(p_game: GameScene, p_board: GameBoard) -> void:
	game = p_game
	board = p_board
	hud = p_game.board_hud
	context_changed.emit()

func is_active() -> bool:
	return _active
