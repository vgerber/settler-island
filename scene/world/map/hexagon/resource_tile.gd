class_name ResourceTile
extends HexagonTile

var assigned_settlements: Array[SettlementLocation] = []
var resource_type: PlayerResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_resource(p_resource_type: PlayerResource) -> void:
	resource_type = p_resource_type

func add_resource_to_settlements() -> void:
	for settlement in assigned_settlements:
		if not settlement.is_village() and not settlement.is_city():
			continue
		
		var resource_count = 1
		if settlement.is_city():
			resource_count += 1
		settlement.player.resources.add_resource(resource_type, resource_count)
