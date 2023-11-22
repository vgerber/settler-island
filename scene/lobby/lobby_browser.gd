class_name LobbyBrowser
extends Control

@onready var user_name_edit: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/UserEdit
@onready var server_address_edit: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/AddressEdit
@onready var server_port_edit: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PortEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_create_server_btn_pressed():
	var created = LobbySession.create_lobby(create_user())
	if not created:
		return
	get_tree().change_scene_to_packed(preload("res://scene/lobby/game_lobby.tscn"))

func _on_connect_btn_pressed():
	var joined = LobbySession.connect_to_lobby(create_user(), server_address_edit.text, int(server_port_edit.text))
	if not joined:
		return
	get_tree().change_scene_to_packed(preload("res://scene/lobby/game_lobby.tscn"))

func create_user() -> User:
	return User.new(user_name_edit.text + "_id", user_name_edit.text)
