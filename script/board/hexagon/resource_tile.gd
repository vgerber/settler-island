class_name ResourceTile
extends HexagonTile

var assigned_settlements: Array[SettlementLocation] = []
var resource_id: String

func _init(p_cube_coordinates: Vector3i, p_assigned_settlements: Array[SettlementLocation], p_resource_id: String):
	super(p_cube_coordinates)
	assigned_settlements = p_assigned_settlements
	resource_id = p_resource_id

static func from_dict(dict: Dictionary) -> HexagonTile:
	var settlements: Array[SettlementLocation] = []
	settlements.assign(dict["assigned_settlements"].map(func(settlement): return SettlementLocation.from_dict(settlement)))
	return ResourceTile.new(HexagonTile.from_dict(dict["tile"]).cube_coordinates, settlements, dict["resource_id"])

func to_dict() -> Dictionary:
	var tile = super.to_dict()
	tile["type"] = 1
	tile["assigned_settlements"] = assigned_settlements.map(func(settlement: SettlementLocation): return settlement.to_dict())
	tile["resource_id"] = resource_id
	return tile
