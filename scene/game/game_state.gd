class_name GameState
extends RefCounted

signal action_changed

var current_action: PlayerAction = null
var actions: Dictionary = {}

func get_current_action() -> PlayerAction:
	return current_action

func set_current_action(action: PlayerAction) -> void:
	current_action = action
	current_action.start()

func get_action(action_id: String) -> PlayerAction:
	return actions[action_id]

func _init(p_game: Game):
	actions[RollDiceAction.get_id()] = RollDiceAction.new()
	actions[EconomySelectionAction.get_id()] = EconomySelectionAction.new()
	
	for action in actions.values():
		action = (action as PlayerAction)
		action.set_context(p_game, p_game.board)
		action.finished.connect(_on_change_action)
	
	
func _on_change_action(next_action: String) -> void:
	var action: PlayerAction = get_action(next_action)
	action.start()
	current_action = action
