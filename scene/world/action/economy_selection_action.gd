class_name EconomySelectionAction
extends PlayerAction


func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "EconomySelectionAction"

func start() -> void:
	hud.end_round_btn.show()
	hud.resource_actions_container.show()
	super.start()

func _on_context_changed() -> void:
	var hud: BoardHUD = game.board_hud
	hud.end_round_btn.pressed.connect(_on_end_turn)
	hud.build_road_btn.pressed.connect(func(): finish(BuildRoadAction.get_id()))
	hud.build_village_btn.pressed.connect(func(): finish(BuildVillageAction.get_id()))
	hud.build_city_btn.pressed.connect(func(): finish(BuildCityAction.get_id()))
	

func _on_end_turn() -> void:
	game.current_player_index = (game.current_player_index + 1) % game.players.size()
	finish(RollDiceAction.get_id())
	
func _on_build_road() -> void:
	pass

func finish(next_action: String) -> void:
	hud.end_round_btn.hide()
	super.finish(next_action)
	
