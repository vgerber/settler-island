class_name RoadLocationScene
extends Node3D

signal changed

var settlement_a: SettlementLocation
var settlement_b: SettlementLocation

var player_id: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_build_location_mouse_button_input(event: InputEventMouseButton):
	if event.pressed:
		return
	
	var game: Game = GameUserSession.game
	var session_player: Player = GameUserSession.player
	if not game.is_player_turn(session_player):
		return
	if player != null and player != session_player:
		return
	if has_road():
		return
	build_road(session_player)

func set_id(id: String) -> void:
	name = id
	$BuildLocation.set_id(id)

func has_road() -> bool:
	return $RoadMesh.visible

func build_road(p_player: Player) -> void:
	$RoadMesh.show()
	player = p_player
	changed.emit()

func set_clickable(clickable: bool) -> void:
	$BuildLocation.visible = clickable
