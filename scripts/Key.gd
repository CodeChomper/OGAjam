extends Area2D
signal key_pick_up
onready var keySample = get_node("keySample")
onready var timer = get_node("Timer")
func _ready():
	connect("body_enter",self,"_on_key_touch")
	pass

func _on_key_touch(body):
	if body.get_name() == "Player":
		clear_shapes()
		print("pick up key")
		keySample.play("key")
		emit_signal("key_pick_up")
		set_hidden(true)
		timer.start()

func _on_Timer_timeout():
	queue_free()
	pass # replace with function body
