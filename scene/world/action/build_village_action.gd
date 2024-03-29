class_name BuildVillageAction
extends PlayerAction

var settlement_map: SettlementMap

func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "BuildVillageAction"

func start() -> void:
	hud.game_actions_container.show()
	hud.cancel_action_btn.show()
	hud.dice_btn.hide()
	hud.end_round_btn.hide()
	hud.resource_actions_container.hide()
	
	show_possible_village_locations()
	super.start()

func _on_context_changed() -> void:
	settlement_map = board.settlement_map
	for village in settlement_map.get_settlements():
		village.changed.connect(func(): _on_village_build(village))
	hud.cancel_action_btn.pressed.connect(_on_cancel)
	
func _on_cancel() -> void:
	finish(EconomySelectionAction.get_id())

func _on_village_build(village: SettlementLocation) -> void:
	finish(EconomySelectionAction.get_id())

func get_possible_village_locations(player: Player) -> Array[SettlementLocation]:
	var villages: Array[SettlementLocation] = []
	villages.assign(game.get_possible_settlement_locations(player)
		.filter(func(settlement: SettlementLocation): return not settlement.is_village() and not settlement.is_city()))
	return villages

func show_possible_village_locations() -> void:
	for village in get_possible_village_locations(GameUserSession.player):
		village.set_clickable(true)

func hide_village_locations() -> void:
	for settlement in settlement_map.get_settlements():
		settlement.set_clickable(false)

func finish(next_action: String) -> void:
	if not is_active():
		return
	hide_village_locations()
	super.finish(next_action)
