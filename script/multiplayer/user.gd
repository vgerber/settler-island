class_name User
extends RefCounted

var id: String
var name: String

func _init(p_id: String, p_name: String):
	id = p_id
	name = p_name

static func from_dict(user: Dictionary) -> User:
	return User.new(user["id"], user["name"])

func to_dict() -> Dictionary:
	return { "id": id, "name": name }
