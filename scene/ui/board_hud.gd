class_name BoardHUD
extends Control

var game: Game
var player: Player
@onready var player_information: PlayerInformation = $PlayerStates/PlayerInformation

@onready var game_actions_container: VBoxContainer = $Actions
@onready var dive_value_lbl: Label = $Actions/DiceValueLbl
@onready var dice_btn: Button = $Actions/RollDiceBtn
@onready var end_round_btn: Button = $Actions/EndRoundBtn
@onready var cancel_action_btn: Button = $Actions/CancelActionBtn

@onready var resource_actions_container: VBoxContainer = $PlayerStates/ResourceActions
@onready var build_road_btn: Button = $PlayerStates/ResourceActions/BuildRoadBtn
@onready var build_village_btn: Button = $PlayerStates/ResourceActions/BuildVillageBtn
@onready var build_city_btn: Button = $PlayerStates/ResourceActions/BuildCityBtn
@onready var build_trade_btn: Button = $PlayerStates/ResourceActions/TradeBtn

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

func set_players(players: Array[Player]) -> void:
	var player_summary_scene = preload("res://scene/ui/board/hud/player_summary_item.tscn")
	for player_index in range(players.size()):
		var player_summary_item = player_summary_scene.instantiate() as PlayerSummeryItem
		$Players.add_child(player_summary_item)
		
		var game_player = players[player_index]
		player_summary_item.set_player_summary(game.get_player_summary(game_player))
		game.current_player_changed.connect(func(): player_summary_item.set_active(game.current_player_index == player_index))
		game_player.changed.connect(func(): player_summary_item.set_player_summary(game.get_player_summary(game_player)))
		player_summary_item.set_active(game.current_player_index == player_index)
		
		
