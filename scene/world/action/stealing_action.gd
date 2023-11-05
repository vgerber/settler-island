class_name StealingMode
extends RefCounted

signal stealed_resources(player: Player, cards: Array[PlayerResource])

func activate(available_players: Array[Player]):
	print("Stealing from palyers...")
