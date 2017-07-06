tool
extends Area2D
export (int,"empty","low","med","full") var fillLevel = 0
export (int,"green","yellow","red","purple") var color = 0

func _ready():
	var sprite = get_node("Sprite")
	if fillLevel == 0:
		sprite.set_frame(0)
	else:
		sprite.set_frame( 3 + (color * 3) + fillLevel-1)
	pass
