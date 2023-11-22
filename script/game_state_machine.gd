class_name GameStateMachine
extends RefCounted

var _transitions: Dictionary
var _current_state: String

func _init(initial_state: String):
	_current_state = initial_state

func get_current_state() -> String:
	return _current_state

func get_states() -> Array[String]:
	var states: Array[String] = []
	states.assign(_transitions.keys())
	return states

func get_next_states(state: String) -> Array[String]:
	var states: Array[String] = []
	states.assign(_transitions[state])
	return states

func go_to_state(state: String) -> bool:
	if not state in get_next_states(_current_state):
		return false
	_current_state = state
	return true
	
