extends Node
var levels = ["scenes/level1.tscn","scenes/level2.tscn","scenes/level3.tscn"]
var curLevel = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_next_level():
	curLevel += 1
	if curLevel >= levels.size():
		curLevel = 0
	return levels[curLevel]