extends Node
onready var parallaxLayer = get_node("ParallaxBackground/ParallaxLayer")

func _ready():
	parallaxLayer.set_hidden(false)
	pass
