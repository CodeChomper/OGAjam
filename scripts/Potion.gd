tool
extends Area2D
export (int,"empty","low","med","full") var fillLevel = 0 setget fillPotion
export (int,"green","yellow","red","purple") var color = 0 setget changePotion
onready var spr = get_node("Sprite")

func _ready():
	fillPotion(fillLevel)
	changePotion(color)
	reInit()
	pass

func fillPotion(val):
	fillLevel = val
	reInit()

func changePotion(val):
	color = val
	reInit()

func reInit():
	if spr == null:
		print("Sprite is null")
		return
	if fillLevel == 0:
		spr.set_frame(0)
	else:
		spr.set_frame(2 + (color * 3) + fillLevel)