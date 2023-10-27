class_name PlayerSummary
extends RefCounted


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_card_count() -> int:
	return 0

func get_player_name() -> String:
	return "PlayerName"

func get_road_count() -> int:
	return 0

func get_victory_points_count() -> int:
	return 0

func get_color() -> Color:
	return Color(0, 0, 0)
