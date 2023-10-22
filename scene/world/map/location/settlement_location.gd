class_name SettlementLocation
extends Node3D

var neighbor_tiles: Array[HexagonTile]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_id(id: String) -> void:
	name = id
	$BuildLocation.set_id(id)
