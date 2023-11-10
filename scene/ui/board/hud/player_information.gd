class_name PlayerInformation
extends PanelContainer

var player: Player

@onready var resource_grid: GridContainer = $MarginContainer/VBoxContainer/PlayerResources

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_player(p_player: Player) -> void:
	player = p_player
	update_data()
	player.changed.connect(update_data)

func update_data() -> void:
	clear_node(resource_grid)
	for player_resource in player.resources.get_resource_keys():
		var resource_name = Label.new()
		resource_name.text = str(player_resource.get_name())
		resource_grid.add_child(resource_name)
		var resource_count = Label.new()
		resource_count.text = str(player.resources.get_resource_count(player_resource))
		resource_grid.add_child(resource_count)

func clear_node(node: Node) -> void:
	while node.get_child_count() > 0:
		node.remove_child(node.get_child(0))
