extends Label

onready var deathsLabel = get_node("DeathsLabel")
onready var skellsLabel = get_node("SkellsLabel")
onready var potionsLabel = get_node("PotionsLabel")
onready var keysLabel = get_node("KeysLabel")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	deathsLabel.set_text("Deaths = " + str(main.times_died))
	skellsLabel.set_text("Skells Killed = " + str(main.skells_killed))
	potionsLabel.set_text("Potions Found = " + str(main.potions_picked_up))
	keysLabel.set_text("Keys Found = " + str(main.keys_found))
	pass


func _on_Button_pressed():
	get_tree().change_scene(main.get_next_level())
	pass # replace with function body
