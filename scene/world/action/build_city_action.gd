class_name BuildCityAction
extends PlayerAction

var settlement_map: SettlementMap

func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "BuildCityAction"

func start() -> void:
	hud.end_round_btn.hide()
	hud.resource_actions_container.hide()
	
	show_possible_city_locations()
	super.start()

func _on_context_changed() -> void:
	settlement_map = board.settlement_map
	for city in settlement_map.get_settlements():
		city.changed.connect(func(): _on_city_build(city))
	hud.cancel_action_btn.pressed.connect(_on_cancel)

func _on_cancel() -> void:
	finish(EconomySelectionAction.get_id())

func _on_city_build(city: SettlementLocation) -> void:
	finish(EconomySelectionAction.get_id())

func get_possible_city_locations(player: Player) -> Array[SettlementLocation]:
	var citys: Array[SettlementLocation] = []
	citys.assign(game.get_possible_settlement_locations(player)
		.filter(func(settlement: SettlementLocation): return settlement.is_village()))
	return citys

func show_possible_city_locations() -> void:
	for city in get_possible_city_locations(GameUserSession.player):
		city.set_clickable(true)

func hide_city_locations() -> void:
	for settlement in settlement_map.get_settlements():
		settlement.set_clickable(false)

func finish(next_action: String) -> void:
	if not is_active():
		return
	hide_city_locations()
	super.finish(next_action)
