tool
extends Area2D
export (int,"empty","low","med","full") var fillLevel = 0 setget fillPotion
export (int,"green","yellow","red","purple") var color = 0 setget changePotion
onready var spr = get_node("Sprite")
signal potion_pick_up

func _ready():
	connect("body_enter",self,"_on_potion_picked_up")
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
		return
	if fillLevel == 0:
		spr.set_frame(0)
	else:
		spr.set_frame(2 + (color * 3) + fillLevel)

func _on_potion_picked_up(body):
	if body.get_name() == "Player":
		print("Picked up")
		emit_signal("potion_pick_up",color)
		queue_free()

func _input_event(viewport, event, shape_idx):
	#event = make_input_local(event)
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed:
        print("Clicked")