class_name BoardHUD
extends Control

var game: Game
var player: Player
@onready var player_information: PlayerInformation = $PlayerStates/PlayerInformation

@onready var dive_value_lbl: Label = $Actions/DiceValueLbl
@onready var dice_btn: Button = $Actions/RollDiceBtn

@onready var end_round_btn: Button = $Actions/EndRoundBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameLog.visible = $HBoxContainer/LogBtn.button_pressed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_player(p_player: Player) -> void:
	player = p_player
	player.changed.connect(update_data)
	player_information.set_player(player)

func update_data() -> void:
	pass



func _on_log_btn_toggled(button_pressed):
	$GameLog.visible = button_pressed

func get_log() -> GameLog:
	return $GameLog
