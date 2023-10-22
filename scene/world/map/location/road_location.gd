class_name RoadLocation
extends Node3D

var settlement_a: SettlementLocation
var settlement_b: SettlementLocation


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_build_location_mouse_button_input(event: InputEventMouseButton):
	if not event.pressed:
		print(name)

func set_id(id: String) -> void:
	name = id
	$BuildLocation.set_id(id)
