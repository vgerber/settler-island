class_name HexagonTile
extends Node3D

signal mouse_button_input(event: InputEventMouseButton)

@export var tile_mesh: MeshInstance3D
@export var size = 5

var cube_coordinates = Vector3i(0, 0, 0):
	set(coordinates):
		cube_coordinates = coordinates
		var q = cube_coordinates.x
		var r = cube_coordinates.y
		position = Vector3(0.75 * width * q, 0, q * 0.5 * height) + Vector3(0, 0, r * height)
		#$TileMesh/CoordinateLabel.text = "(%s,%s,%s)" % [coordinates.x, coordinates.y, coordinates.z]
var height = size * sqrt(3)
var width = size * 2

var click_location: ClickLocation =  preload("res://scene/world/map/location/click_location.tscn").instantiate()

func _init():
	#set_debug_color(Color(randf(), randf(), randf()))
	add_child(click_location)
	click_location.visible = true
	click_location.position.y += 2
	click_location.mouse_button_input.connect(func(event: InputEventMouseButton): mouse_button_input.emit(event))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_debug_color(color: Color):
	tile_mesh.material_override.albedo_color = color

func set_clickable(clickable: bool) -> void:
	click_location.visible = clickable
