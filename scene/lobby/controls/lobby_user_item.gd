class_name LobbyUserItem
extends PanelContainer

func set_user(user: LobbyUser):
	$MarginContainer/PlayerName.text = user.user.name
