class_name EconomySelectionAction
extends PlayerAction


func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "EconomySelectionAction"

func start() -> void:
	hud.end_round_btn.show()
	super.start()

func _on_context_changed() -> void:
	var hud: BoardHUD = game.board_hud
	hud.end_round_btn.pressed.connect(_on_end_turn)

func _on_end_turn() -> void:
	game.end_turn(GameUserSession.player)
	game.current_player_index = (game.current_player_index + 1) % game.players.size()
	finish(RollDiceAction.get_id())
	
func finish(next_action: String) -> void:
	hud.end_round_btn.hide()
	super.finish(next_action)
	
