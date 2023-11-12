class_name StartVillagePlacementAction
extends PlayerAction

var settlement_map: SettlementMap

func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "StartVillagePlacementAction"

func start() -> void:
	hud.game_actions_container.hide()
	hud.resource_actions_container.hide()
	
	show_possible_village_locations()
	super.start()

func _on_context_changed() -> void:
	settlement_map = board.settlement_map
	for village in settlement_map.get_settlements():
		village.changed.connect(func(): _on_village_build(village))

func _on_village_build(village: SettlementLocation) -> void:
	var current_player: Player = game.players[game.current_player_index]
	var next_player: Player = game.players[game.get_next_player_index(game.current_player_index)]
	var has_two_settlements = board.settlement_map.get_player_settlements(current_player).size() == 2
	var is_last_player = game.current_player_index == game.players.size()-1
	
	var player_settlements = board.settlement_map.get_player_settlements(current_player)
	
	if is_last_player and not has_two_settlements:
		refresh_possible_locations()
		return
	
	game.current_player_index = game.get_next_player_index(game.current_player_index)
	if board.settlement_map.get_player_settlements(next_player).size() == 2:
		finish(RollDiceAction.get_id())

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

func refresh_possible_locations() -> void:
	hide_village_locations()
	show_possible_village_locations()

func finish(next_action: String) -> void:
	super.finish(next_action)
