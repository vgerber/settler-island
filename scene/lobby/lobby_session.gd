extends Node

signal user_joined(id: int, user: LobbyUser)
signal user_left(id: int, user: LobbyUser)
signal lobby_closed()

const SERVER_PORT: int = 8342

var game: Game
var users: Dictionary = {}

var user: LobbyUser

# Called when the node enters the scene tree for the first time.
func _ready():
	#(multiplayer as SceneMultiplayer).allow_object_decoding = true
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_peer_connected(id: int) -> void:
	print("Peer connected %s" % str(id))

func _on_peer_disconnected(id: int) -> void:
	_remove_user(id)
	
func _on_connected_to_server() -> void:
	_add_user(multiplayer.get_unique_id(), user)
	_register_player.rpc_id(1, user.user.name)
	
	
func _on_connection_failed() -> void:
	multiplayer.multiplayer_peer = null

func _on_server_disconnected() -> void:
	multiplayer.multiplayer_peer = null
	users.clear()
	lobby_closed.emit()

func create_lobby(p_user: User) -> bool:
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(SERVER_PORT, 4)
	if error:
		return false
	multiplayer.multiplayer_peer = peer
	user = LobbyUser.new(p_user)
	_add_user(1, user)
	return true
	

func connect_to_lobby(p_user: User, address: String, port: int) -> bool:
	user = LobbyUser.new(p_user)
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, port)
	if error:
		print("Connect failed %s" % str(error))
		return false
	multiplayer.multiplayer_peer = peer
	return true
	

@rpc("authority", "reliable", "call_local")
func start_game() -> void:
	pass

@rpc("any_peer", "reliable")
func _register_player(user_name: String) -> void:
	_add_user(get_multiplayer().get_remote_sender_id(), _lobby_user_form_string(user_name))
	var user_names = {}
	for user_id in users.keys():
		user_names[user_id] = users[user_id].user.name
	_registered_players_changed.rpc(user_names)

@rpc("authority", "reliable")
func _registered_players_changed(p_users: Dictionary) -> void:
	print(p_users)
	for user_id in p_users.keys():
		_add_user(user_id, _lobby_user_form_string(p_users[user_id]))

func is_host() -> bool:
	return multiplayer.is_server()

func _add_user(id: int, user: LobbyUser) -> void:
	if users.has(id):
		return
	users[id] = user
	user_joined.emit(id, user)

func _remove_user(id: int) -> void:
	if not users.has(id):
		return
	var user = users[id]
	users.erase(id)
	user_left.emit(id, user)

func _lobby_user_form_string(name: String) -> LobbyUser:
	return LobbyUser.new(User.new(name))
