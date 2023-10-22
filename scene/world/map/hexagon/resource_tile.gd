class_name ResourceTile
extends HexagonTile

var assigned_settlements: Array[SettlementLocation] = []
var resource_type: PlayerResources.BaseResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_resource(p_resource_type: PlayerResources.BaseResource) -> void:
	resource_type = p_resource_type
