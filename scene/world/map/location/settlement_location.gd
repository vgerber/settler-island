class_name SettlementLocationScene
extends Node3D

signal changed

var neighbor_tiles: Array[HexagonTile]
var player_id: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_id(id: String) -> void:
	name = id
	$BuildLocation.set_id(id)


func _on_build_location_mouse_button_input(event: InputEventMouse):
	if not event is InputEventMouseButton:
		return
	if (event as InputEventMouseButton).pressed:
		return
	
	var player = GameUserSession.player
	if not GameUserSession.game.is_player_turn(player):
		return
	if is_village():
		player_place_city(player)
	else:
		player_place_village(player)

func is_village() -> bool:
	return $VillageMesh.visible
	
func is_city() -> bool:
	return $CityMesh.visible

func reset() -> void:
	$VillageMesh.hide()
	$CityMesh.hide()
	player_id = ""

func player_place_village(p_player_id: String) -> bool:
	if not player_id.is_empty() and player_id != p_player_id:
		return false
	if is_village() or is_city():
		return false
	set_village(p_player_id)
	changed.emit()
	return true

func player_place_city(p_player_id: String) -> bool:
	if player_id != p_player_id:
		return false
	if not is_village():
		return false
	set_city(p_player_id)
	changed.emit()
	return true

func set_village(p_player_id: String) -> void:
	player_id = p_player_id
	$VillageMesh.show()

func set_city(p_player_id: String) -> void:
	player_id = p_player_id
	$VillageMesh.hide()
	$CityMesh.show()	

func set_clickable(clickable: bool) -> void:
	$BuildLocation.visible = clickable
