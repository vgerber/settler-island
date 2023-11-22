class_name GameBoard
extends RefCounted

var tile_map: HexagonMap
var settlement_map: SettlementMap
var dice_chips: Array[DiceChipLocation]
var robber: RobberLocation
var board_resources: Array[String]

func _init(p_tile_map: HexagonMap, p_settlement_map: SettlementMap, p_dice_chips: Array[DiceChipLocation], p_robber: RobberLocation, p_board_resources: Array[String]):
	tile_map = p_tile_map
	settlement_map = p_settlement_map
	dice_chips = p_dice_chips
	robber = p_robber
	board_resources = p_board_resources

static func from_dict(dict: Dictionary) -> GameBoard:
	var dice_chips: Array[DiceChipLocation] = []
	dice_chips.assign(dict["dice_chips"].map(func(chip): DiceChipLocation.from_dict(chip)))
	return GameBoard.new(
		HexagonMap.from_dict(dict["tile_map"]),
		SettlementMap.from_dict(dict["settlement_map"]),
		dice_chips,
		RobberLocation.from_dict(dict["robber_location"]),
		dict["board_resources"]
	)

func to_dict() -> Dictionary:
	return {
		"tile_map": tile_map.to_dict(),
		"settlement_map": settlement_map.to_dict(),
		"dice_chips": dice_chips.map(func(chip): return chip.to_dict()),
		"robber": robber.to_dict(),
		"board_resources": board_resources
	}
