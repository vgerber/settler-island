class_name SettlementLocation
extends Node3D

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


func _on_build_location_mouse_button_input(event):
	pass # Replace with function body.

func is_village() -> bool:
	return $VillageMesh.visible
	
func is_city() -> bool:
	return $CityMesh.visible

func reset() -> void:
	$VillageMesh.hide()
	$CityMesh.hide()
	player = null

func place_village(p_player: Player) -> bool:
	if player != p_player:
		return false
	if is_village() or is_city():
		return false
	$VillageMesh.show()
	return true

func place_city(p_player: Player) -> bool:
	if player != p_player:
		return false
	if not is_village():
		return false
	$VillageMesh.hide()
	$CityMesh.show()
	return true
