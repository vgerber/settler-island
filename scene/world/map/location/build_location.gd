class_name BuildLocation
extends Node3D

signal mouse_button_input(event: InputEventMouse)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_id(id: String):
	$LocationMesh/IdLabel.text = id


func _on_mouse_area_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		mouse_button_input.emit(event)


func _on_mouse_area_mouse_entered():
	$LocationMesh.show()


func _on_mouse_area_mouse_exited():
	$LocationMesh.hide()
