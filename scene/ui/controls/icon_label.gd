extends Control

@export var label_settings: LabelSettings:
	set(settings):
		label_settings = settings
		$HBoxContainer/Label.label_settings = settings
@export var icon: Texture2D:
	set(p_icon):
		icon = p_icon
		$HBoxContainer/TextureRect.texture = icon
@export var text: String: 
	set(p_text):
		$Label.text = p_text
	get:
		return $Label.text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
