extends StaticBody2D
onready var leftRay = get_node("LeftRay")
onready var rightRay = get_node("RightRay")
onready var animSpr = get_node("AnimatedSprite")
export (int, "Closed", "Locked", "Open") var state = "Closed"
signal use_key
func _ready():
	set_process(true)
	pass

func _process(delta):
	if leftRay.is_colliding():
		if state == 1:
			emit_signal("use_key",self)
		if state == 0:
			state = 2
			animSpr.play("OpenRight")
	if rightRay.is_colliding():
		if state == 1:
			emit_signal("use_key",self)
		if state == 0:
			state = 2
			animSpr.play("OpenLeft")

func _on_AnimatedSprite_finished():
	self.clear_shapes();
	pass # replace with function body
