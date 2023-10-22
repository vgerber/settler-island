extends Node3D

var value: int = 0
var assigned_tile: ResourceTile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_value(p_value: int) -> void:
	value = p_value
	$ChipMesh/ChipValue.text = str(value)
