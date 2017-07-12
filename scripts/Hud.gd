extends CanvasLayer
var POTION_TYPES = ["Green", "Yellow", "Red", "Purple"]
var inv = [0,0,0,0]
onready var labels = [get_node("greenLabel"), get_node("yellowLabel"), get_node("redLabel"), get_node("purpleLabel")]
onready var panel = get_node("Panel")
signal DrinkGreen
signal DrinkYellow
signal DrinkRed
signal DrinkPurple

func _ready():
	pass

func _on_Potion_potion_pick_up(type):
	inv[type] += 1
	update_labels()
	pass # replace with function body

func update_labels():
	for i in range(labels.size()):
		labels[i].set_text(str(inv[i]))

func _input_event(viewport, event, shape_idx):
	#event = make_input_local(event)
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed:
        print("Clicked")

func _on_button_pressed(type):
	if type == 0 and inv[type] > 0:
		print("Green")
		inv[type] -=1
	elif type == 1 and inv[type] > 0:
		print("Yellow")
		inv[type] -=1
	elif type == 2 and inv[type] > 0:
		print("Red")
		emit_signal("DrinkRed")
		inv[type] -=1
	elif type == 3 and inv[type] > 0:
		print("Purple")
		inv[type] -=1
	else:
		print("You do not have that in inventory")
	
	#need to reset focus
	panel.set_focus_mode(3)
	update_labels()
	pass # replace with function body
