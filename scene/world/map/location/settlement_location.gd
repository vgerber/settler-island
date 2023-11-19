class_name SettlementLocationScene
extends Node3D

signal changed

var neighbor_tiles: Array[HexagonTile]
var player: Player = null

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
		place_city(player)
	else:
		place_village(player)
		

func is_village() -> bool:
	return $VillageMesh.visible
	
func is_city() -> bool:
	return $CityMesh.visible

func reset() -> void:
	$VillageMesh.hide()
	$CityMesh.hide()
	player = null

func place_village(p_player: Player) -> bool:
	if player != null and player != p_player:
		return false
	if is_village() or is_city():
		return false
	player = p_player
	$VillageMesh.show()
	changed.emit()
	return true

func place_city(p_player: Player) -> bool:
	if player != p_player:
		return false
	if not is_village():
		return false
	$VillageMesh.hide()
	$CityMesh.show()
	changed.emit()
	return true

func set_clickable(clickable: bool) -> void:
	$BuildLocation.visible = clickable
