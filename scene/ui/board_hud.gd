class_name BoardHUD
extends Control

var game: Game
var player: Player
@onready var player_information: PlayerInformation = $PlayerInformation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_player(p_player: Player) -> void:
	player = p_player
	player.changed.connect(update_data)
	player_information.set_player(player)

func update_data() -> void:
	pass


func _on_roll_dice_btn_pressed():
	var dices = game.roll_dice()
	var dice_value = dices[0] + dices[1]
	print(dice_value)
	
	var tiles = game.board.get_tiles_for_chip_value(dice_value)
	print(tiles)
	for tile in tiles:
		for settlement in tile.assigned_settlements:
			print(settlement)
