class_name PlaceRobberMode
extends RefCounted

var board: Board
var active = false

func _init(p_board: Board):
	board = p_board
	for tile in board.robber_tiles:
		tile.mouse_button_input.connect(tile_mouse_input)

func activate() -> void:
	for tile in board.robber_tiles:
		if tile == board.robber.assigned_tile:
			continue
		tile.set_clickable(true)
	active = true

func deactivate() -> void:
	for tile in board.robber_tiles:
		tile.set_clickable(false)
	active = false

func tile_mouse_input(tile: HexagonTile, event: InputEventMouseButton) -> void:
	if not active:
		return
	if event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
		return
	place_robber(tile)
	
func place_robber(tile: HexagonTile) -> void:
	deactivate()
	board.robber.assign_tile(tile)
