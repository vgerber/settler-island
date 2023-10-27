class_name Game
extends Node

@onready var board: Board = $Board
@onready var board_hud: BoardHUD = $BoardHUD

var players: Array[Player]
var current_player_index = 0

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	board_hud.game = self
	for player_index in range(4):
		players.push_back(Player.new(BaseResources.new(get_resources())))
	board_hud.set_player(players[0])
	GameUserSession.player = players[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_dice() -> Array[int]:
	return [randi_range(1, 6), randi_range(1, 6)]

func get_resources() -> Array[PlayerResource]:
	return board.board_resources

func is_player_turn(player: Player) -> bool:
	return player == players[current_player_index]
	
func end_turn(player: Player) -> void:
	if not is_player_turn(player):
		return
	current_player_index = (current_player_index + 1) % players.size()
