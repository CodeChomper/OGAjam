extends KinematicBody2D

onready var rayFloor = get_node("rayFloor")
onready var rayFloor1 = get_node("rayFloor1")
onready var rayWall = get_node("rayWall")
onready var fbHitBox = get_node("FBHitBox")
onready var sprite = get_node("Sprite")
onready var onGround = false
onready var vel = Vector2(0,0)
export var WALK_SPEED = 10
export var JUMP_SPEED = 170
export var GRAVITY = 500
onready var facingLeft = false
onready var state = "idle"
onready var anim = get_node("AnimationPlayer")
onready var animSprite = get_node("AnimatedSprite")
onready var tellaportTimmer = get_node("TellaportTimer")
onready var camera = get_node("Camera2D")
onready var powerUpTimer = get_node("PowerUpTimer")
signal Health_Change

func _ready():
	set_fixed_process(true)
	rayFloor.add_exception(self)
	rayWall.add_exception(self)
	fbHitBox.connect("body_enter",self,"_on_hit")
	emit_signal("Health_Change", main.health)
	pass

func _fixed_process(delta):
	var left = Input.is_action_pressed("p_left")
	var right = Input.is_action_pressed("p_right")
	var jump = Input.is_action_pressed("p_jump")
	
	if main.health <= 0 or get_pos().y > camera.get_pos().y + 800:
		main.inv = [0,0,0,0]
		main.times_died += 1
		get_tree().reload_current_scene()
	
	onGround = rayFloor.is_colliding() or rayFloor1.is_colliding()
	
	if rayFloor.is_colliding():
		var obj = rayFloor.get_collider()
		if obj.is_in_group("BadGuy") and obj.state != "dead":
			print("steped on head")
			rayFloor.get_collider().health = 0
	
	if rayFloor1.is_colliding():
		var obj = rayFloor1.get_collider()
		if rayFloor1.get_collider().is_in_group("BadGuy") and obj.state != "dead":
			print("steped on head")
			rayFloor1.get_collider().health = 0
	
	# Handle Movement
	gravity(delta)
	if left and state != "drinking":
		flip(true)
		vel.x -= WALK_SPEED
	if right and state != "drinking":
		flip(false)
		vel.x += WALK_SPEED
	vel.x *= 0.9
	if rayWall.is_colliding():
		vel.x = 0;
	
	if (right or left) and onGround and state != "drinking":
		state = "Walk"
	
	if onGround and state != "drinking" and abs(vel.x) < 3:
		state = "idle"
	
	var motion = vel * delta
	move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)
	
	# Handle Jump
	if rayFloor.is_colliding() and jump:
		vel.y -= JUMP_SPEED
	
	if !onGround:
		state = "jump"
	
	var animation = anim.get_current_animation()
	if animation != state:
		anim.play(state)

func gravity(delta):
	vel.y += GRAVITY * delta

func flip(left):
	var s = get_scale()
	if left: s.x *= -1
	else: s.x *= 1
	set_scale(s)

func _on_hit(body):
	if body.is_in_group("BadGuy") and body.state != "dead":
		print("ouch")
		main.health -= 25
		emit_signal("Health_Change", main.health)

func _on_Potion_potion_pick_up(type):
	print("add to inv ", type)
	pass # replace with function body

func _on_AnimatedSprite_finished():
	animSprite.set_hidden(true)
	animSprite.stop()
	sprite.set_hidden(false)
	print(state)
	if animSprite.get_animation() == "DrinkRed":
		print("reload scene")
		get_tree().reload_current_scene()
	
	#do yellow effects!
	if animSprite.get_animation() == "DrinkYellow":
		JUMP_SPEED = 270
		state = "idle"
		powerUpTimer.start()
	
	#do green effects!
	if animSprite.get_animation() == "DrinkGreen":
		WALK_SPEED = 20
		state = "idle"
		powerUpTimer.start()
	
	#do purple effects!
	if animSprite.get_animation() == "DrinkPurple":
		main.health += 25
		emit_signal("Health_Change", main.health)
		state = "idle"

func _on_Tellaport_body_enter( body ):
	if body.get_name() == "Player":
		tellaportTimmer.start()
		animSprite.play("Shocked")
		animSprite.set_hidden(false)
		sprite.set_hidden(true)
	pass # replace with function body

func _on_TellaportTimer_timeout():
	get_tree().change_scene(main.get_next_level())
	pass # replace with function body

func _on_PowerUpTimer_timeout():
	JUMP_SPEED = 170
	WALK_SPEED = 10
	pass # replace with function body

func _on_Hud_DrinkRed():
	drink("DrinkRed")

func _on_Hud_DrinkYellow():
	drink("DrinkYellow")

func _on_Hud_DrinkGreen():
	drink("DrinkGreen")

func _on_Hud_DrinkPurple():
	drink("DrinkPurple")

func drink(animation):
	sprite.set_hidden(true)
	animSprite.set_frame(0)
	animSprite.set_hidden(false)
	animSprite.play(animation)
	state = "drinking"
