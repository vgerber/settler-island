class_name Game
extends Node

@onready var board: Board = $Board

var players: Array[Player]
var current_player_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_dice() -> Array[int]:
	return [randi_range(1, 6), randi_range(1, 6)]
