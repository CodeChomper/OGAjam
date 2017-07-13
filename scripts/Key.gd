extends Area2D
signal key_pick_up

func _ready():
	connect("body_enter",self,"_on_key_touch")
	pass

func _on_key_touch(body):
	if body.get_name() == "Player":
		print("pick up key")
		emit_signal("key_pick_up")
		queue_free()