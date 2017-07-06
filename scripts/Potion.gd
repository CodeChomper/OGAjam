tool
extends Area2D
export (int,"empty","low","med","full") var fillLevel = 0 setget fillPotion
export (int,"green","yellow","red","purple") var color = 0 setget changePotion
var sprite

func _ready():
	sprite = get_node("potionSprite")
	pass

func fillPotion(val):
	fillLevel = val
	reInit()

func changePotion(val):
	color = val
	reInit()

func reInit():
	sprite = get_node("potionSprite")
	if fillLevel == 0:
		sprite.set_frame(0)
	else:
		sprite.set_frame(2 + (color * 3) + fillLevel)