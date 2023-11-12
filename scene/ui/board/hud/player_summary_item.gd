class_name PlayerSummeryItem
extends PanelContainer

@onready var player_name: Label = $MarginContainer/HBoxContainer/VBoxContainer/PlayerNameLabel
@onready var cards: IconLabel = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/CardsLabel

@export var default_color: Color = Color(0.3, 0.3, 0.3)
@export var active_color: Color = Color(0.4, 1, 0.2)

var style_box: StyleBoxFlat

# Called when the node enters the scene tree for the first time.
func _ready():
	style_box = get_theme_stylebox("panel")
	set_active(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active(active: bool) -> void:
	if active:
		style_box.border_color = active_color
	else:
		style_box.border_color = default_color

func set_player_summary(player_summary: PlayerSummary) -> void:
	player_name.text = player_summary.name
	cards.text = str(player_summary.card_count)
