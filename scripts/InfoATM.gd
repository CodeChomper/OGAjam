tool
extends Area2D
onready var label = get_node("TextPanel/Label")
onready var textPanel = get_node("TextPanel")
export (String, MULTILINE) var text setget _on_text_set

func _ready():
	_on_text_set(text)
	pass

func _on_text_set(value):
	text = value
	if value == null or label == null or textPanel == null:
		return
	print("_on_text_set("+value+")")
	var lh = label.get_line_height()
	var lCnt = label.get_line_count() + 1
	var s = textPanel.get_size()
	textPanel.set_size(Vector2(s.x,lCnt * lh + 10))
	label.set_text(value)
	pass

func _on_InfoATM_body_enter( body ):
	textPanel.set_hidden(false)
	pass # replace with function body


func _on_InfoATM_body_exit( body ):
	textPanel.set_hidden(true)
	pass # replace with function body
