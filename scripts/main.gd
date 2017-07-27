extends Node
var levels = ["scenes/level1.tscn","scenes/level2.tscn","scenes/level3.tscn","scenes/level4.tscn","scenes/level5.tscn","scenes/level6.tscn","scenes/endLevel.tscn"]
var curLevel = 0
var inv = [0,0,0,0]
var health = 100
var potions_picked_up = 0
var times_died = 0
var skells_killed = 0
var keys_found = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_next_level():
	curLevel += 1
	if curLevel >= levels.size():
		curLevel = 0
	return levels[curLevel]