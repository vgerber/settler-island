class_name HexagonTile
extends Node3D

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

# Called when the node enters the scene tree for the first time.
func _ready():
	set_debug_color(Color(randf(), randf(), randf()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if not event is InputEventMouseButton:
		return
	
	event = event as InputEventMouseButton
	if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		print(cube_coordinates)

func set_debug_color(color: Color):
	tile_mesh.material_override.albedo_color = color
