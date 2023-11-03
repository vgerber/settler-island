class_name GameLogEntry
extends HBoxContainer

var unix_time: float
var icon: Texture2D
var message: String

func _init(p_unix_time: float, p_icon: Texture2D, p_message: String):
	unix_time = p_unix_time
	icon = p_icon
	message = p_message

# Called when the node enters the scene tree for the first time.
func _ready():	
	var time_label = Label.new()
	time_label.text = Time.get_datetime_string_from_unix_time(unix_time)
	time_label.hide() 
	add_child(time_label)
	
	var icon_image = TextureRect.new()
	icon_image.texture = icon
	icon_image.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	add_child(icon_image)
	
	var message_label = Label.new()
	message_label.text = message
	add_child(message_label)
