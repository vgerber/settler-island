class_name HexagonTileScene
extends Node3D

signal mouse_button_input(event: InputEventMouseButton)

@export var tile_mesh: MeshInstance3D
@export var size = 5


var cube_coordinates = Vector3i(0, 0, 0):
	set(coordinates):
		cube_coordinates = coordinates
		position = Hexagon.get_tile_position(cube_coordinates.x, cube_coordinates.y, width, height)
		#$TileMesh/CoordinateLabel.text = "(%s,%s,%s)" % [coordinates.x, coordinates.y, coordinates.z]
var height = size * sqrt(3)
var width = size * 2

var click_location: ClickLocation =  preload("res://scene/world/map/location/click_location.tscn").instantiate()

func _init():
	#set_debug_color(Color(randf(), randf(), randf()))
	add_child(click_location)
	click_location.visible = false
	click_location.position.y += 2
	click_location.mouse_button_input.connect(func(event: InputEventMouseButton): mouse_button_input.emit(event))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_debug_color(color: Color):
	tile_mesh.material_override.albedo_color = color

func set_clickable(clickable: bool) -> void:
	click_location.visible = clickable
