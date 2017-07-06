extends Sprite

func _ready():
	var player = load("res://scenes/Player.tscn").instance()
	set_self_opacity(0)
	add_child(player)
	
	pass
