class_name LobbyUser
extends RefCounted

var user_id: String

func _init(p_user_id: String):
	user_id = p_user_id
	
static func from_dict(user: Dictionary) -> LobbyUser:
	return LobbyUser.new(user["user_id"])

func to_dict() -> Dictionary:
	return { "user_id": user_id }
