class_name RollDiceAction
extends PlayerAction

func _init():
	context_changed.connect(_on_context_changed)

static func get_id() -> String:
	return "RollDiceAction"

func start() -> void:
	hud.dice_btn.show()
	super.start()

func _on_context_changed() -> void:
	hud.dice_btn.pressed.connect(_on_roll_dice)

func _on_roll_dice() -> void:
	var dices = game.roll_dice()
	var dice_value = dices[0] + dices[1]
	hud.get_log().log_generic(Time.get_unix_time_from_system(), load("res://asset/icon/action/dice_icon.svg"), "Dice %s" % dice_value)
	hud.dive_value_lbl.text = str(dice_value)
	hud.dive_value_lbl.show()
	
	var tiles = game.board.get_tiles_for_chip_value(dice_value)
	for tile in tiles:
		tile.add_resource_to_settlements()
	finish(EconomySelectionAction.get_id())

func finish(next_action: String) -> void:
	hud.dice_btn.hide()
	super.finish(next_action)
