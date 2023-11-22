class_name DictUtils
extends RefCounted

static func color_to_dict(color: Color) -> Dictionary:
	return {
		"r": color.r,
		"g": color.g,
		"b": color.b,
		"a": color.a
	}

static func color_from_dict(dict: Dictionary) -> Color:
	return Color(dict["r"], dict["g"], dict["b"], dict["a"])

static func vector3i_to_dict(vector: Vector3i) -> Dictionary:
	return {
		"x": vector.x,
		"y": vector.y,
		"z": vector.z
	}

static func vector3i_from_dict(dict: Dictionary) -> Vector3i:
	return Vector3i(dict["x"], dict["y"], dict["z"])
