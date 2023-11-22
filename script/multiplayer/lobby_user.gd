class_name LobbyUser
extends RefCounted

var user: User

func _init(p_user: User):
	user = p_user
	
static func from_dict(user: Dictionary) -> LobbyUser:
	return LobbyUser.new(User.from_dict(user["user"]))

func to_dict() -> Dictionary:
	return { "user": user.to_dict() }
