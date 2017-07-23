extends Area2D
onready var sfx = get_node("SamplePlayer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Tellaport_body_enter( body ):
	if body.get_name() == "Player":
		sfx.play("tellaport")
	pass # replace with function body
