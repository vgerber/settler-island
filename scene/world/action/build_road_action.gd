class_name BuildRoadAction
extends PlayerAction

var settlement_map: SettlementMap

func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "BuildRoadAction"

func start() -> void:
	hud.game_actions_container.show()
	hud.dice_btn.hide()
	hud.cancel_action_btn.hide()
	hud.end_round_btn.hide()
	hud.resource_actions_container.hide()

	show_possible_road_locations()
	super.start()

func _on_context_changed() -> void:
	settlement_map = board.settlement_map
	for road in settlement_map.get_roads():
		road.changed.connect(func(): _on_road_build(road))
	hud.cancel_action_btn.pressed.connect(_on_cancel)

func _on_cancel() -> void:
	finish(EconomySelectionAction.get_id())

func _on_road_build(road: RoadLocation) -> void:
	finish(EconomySelectionAction.get_id())

func get_possible_road_locations(player: Player) -> Array[RoadLocation]:
	return board.settlement_map.get_interactable_road_locations(player)

func show_possible_road_locations() -> void:
	for road in get_possible_road_locations(GameUserSession.player):
		road.set_clickable(true)

func hide_road_locations() -> void:
	for road in settlement_map.get_roads():
		road.set_clickable(false)

func finish(next_action: String) -> void:
	if not is_active():
		return
	hide_road_locations()
	super.finish(next_action)
