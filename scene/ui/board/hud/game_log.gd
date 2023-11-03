class_name GameLog
extends PanelContainer

@onready var scroll_container: ScrollContainer = $ScrollContainer
var follow: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_container.get_v_scroll_bar().changed.connect(scroll_to_bottom)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func log_generic(unix_time: int, icon: Texture2D, message: String):
	$ScrollContainer/MarginContainer/VBoxContainer.add_child(GameLogEntry.new(unix_time, icon, message))

func scroll_to_bottom() -> void:
	var scrollbar = scroll_container.get_v_scroll_bar()
	if scrollbar.max_value != scrollbar.value:
		scroll_container.scroll_vertical = scrollbar.max_value
