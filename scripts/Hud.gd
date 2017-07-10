extends CanvasLayer
var POTION_TYPES = ["Green", "Yellow", "Red", "Purple"]
var inv = [0,0,0,0]
onready var labels = [get_node("greenLabel"), get_node("yellowLabel"), get_node("redLabel"), get_node("purpleLabel")]

func _ready():
	pass

func _on_Potion_potion_pick_up(type):
	inv[type] += 1
	for i in range(labels.size()):
		labels[i].set_text(str(inv[i]))
	pass # replace with function body

func _input_event(viewport, event, shape_idx):
	#event = make_input_local(event)
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed:
        print("Clicked")