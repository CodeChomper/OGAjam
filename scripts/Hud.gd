extends CanvasLayer
var POTION_TYPES = ["Green", "Yellow", "Red", "Purple"]
onready var labels = [get_node("greenLabel"), get_node("yellowLabel"), get_node("redLabel"), get_node("purpleLabel")]
onready var keyLabel = get_node("keyLabel")
onready var panel = get_node("Panel")
onready var sfx = get_node("SFX")
onready var potionSoundTimer = get_node("potion_sound_timer")
onready var powerUpTimeLeft = get_node("PowerUpTImeLeft")
onready var heart1 = get_node("Heart1")
onready var heart2 = get_node("Heart2")
onready var heart3 = get_node("Heart3")
onready var heart4 = get_node("Heart4")
onready var scoreLabel = get_node("ScoreLabel")

signal DrinkGreen
signal DrinkYellow
signal DrinkRed
signal DrinkPurple
var keys = 0
var pTimeLeft = 0

func _ready():
	self.set_offset(Vector2(0,0))
	set_process(true)
	update_labels()
	pass

func _process(delta):
	if pTimeLeft > 0:
		pTimeLeft = pTimeLeft - delta
	else:
		pTimeLeft = 0
	powerUpTimeLeft.set_text(str(round(pTimeLeft)))
	
	scoreLabel.set_text("Score: " + str((main.skells_killed * 5) + (main.times_died * -10) + (main.potions_picked_up * 2) + (main.keys_found * 5)))

func _on_Potion_potion_pick_up(type):
	main.inv[type] += 1
	main.potions_picked_up += 1
	update_labels()
	sfx.play("bottle")
	pass # replace with function body

func update_labels():
	for i in range(labels.size()):
		labels[i].set_text(str(main.inv[i]))
	keyLabel.set_text(str(keys))
	
	

func _input_event(viewport, event, shape_idx):
	#event = make_input_local(event)
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed:
        print("Clicked")

func _on_button_pressed(type):
	pTimeLeft = 12
	if type == 0 and main.inv[type] > 0:
		print("Green")
		emit_signal("DrinkGreen")
		main.inv[type] -=1
		potionSoundTimer.start()
	elif type == 1 and main.inv[type] > 0:
		print("Yellow")
		emit_signal("DrinkYellow")
		main.inv[type] -=1
		potionSoundTimer.start()
	elif type == 2 and main.inv[type] > 0:
		print("Red")
		emit_signal("DrinkRed")
		main.inv[type] -=1
		main.times_died += 1
		potionSoundTimer.start()
	elif type == 3 and main.inv[type] > 0:
		print("Purple")
		emit_signal("DrinkPurple")
		main.inv[type] -=1
		potionSoundTimer.start()
	else:
		pTimeLeft = 0
		print("You do not have that in inventory")
	
	#need to reset focus
	panel.set_focus_mode(3)
	update_labels()
	pass # replace with function body


func _on_key_pick_up():
	keys += 1
	main.keys_found += 1
	update_labels()
	pass # replace with function body


func _on_Door_use_key(door):
	if keys > 0:
		door.state = 0
		keys -= 1
		sfx.play("useKey")
		update_labels()
	pass # replace with function body


func _on_potion_sound_timer_timeout():
	sfx.play("usePotion")
	pass # replace with function body


func _on_Player_Health_Change(health):
	if health == 100:
		heart1.play("Red")
		heart2.play("Red")
		heart3.play("Red")
		heart4.play("Red")
	elif health == 75:
		heart1.play("Red")
		heart2.play("Red")
		heart3.play("Red")
		heart4.play("Grey")
	elif health == 50:
		heart1.play("Red")
		heart2.play("Red")
		heart3.play("Grey")
		heart4.play("Grey")
	elif health == 25:
		heart1.play("Red")
		heart2.play("Grey")
		heart3.play("Grey")
		heart4.play("Grey")
	else:
		return
