class_name GameLobby
extends Control

@onready var players_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Players

# Called when the node enters the scene tree for the first time.
func _ready():
	LobbySession.user_joined.connect(_on_user_joined)
	LobbySession.user_left.connect(_on_user_left)
	update_users()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_user_joined(id: int, user: LobbyUser) -> void:
	update_users()

func _on_user_left(id: int, user: LobbyUser) -> void:
	update_users()

func update_users() -> void:
	for player in players_list.get_children():
		player.queue_free()
	
	for lobby_user in LobbySession.users.values():
		lobby_user = lobby_user as LobbyUser
		var user_item: LobbyUserItem = preload("res://scene/lobby/controls/lobby_user_item.tscn").instantiate()
		user_item.set_user(lobby_user)
		players_list.add_child(user_item)

func generate_game() -> Game:
	var board = BaseBoardGenerator.new().generate_board()
	
	var players: Array[Player] = []
	for lobby_user in LobbySession.users:
		lobby_user = lobby_user as LobbyUser
		players.push_back(Player.new(lobby_user.user_id, lobby_user.user_id, BaseResources.new(board.board_resources), Color(randf(), randf(), randf())))
	return Game.new(board, players)
