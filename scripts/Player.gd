extends KinematicBody2D

onready var rayFloor = get_node("rayFloor")
onready var onGround = false
onready var vel = Vector2(0,0)
onready var WALK_SPEED = 10
onready var JUMP_SPEED = 70
onready var GRAVITY = 300
onready var facingLeft = false
onready var state = "idle"
onready var anim = get_node("AnimationPlayer")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var left = Input.is_action_pressed("p_left")
	var right = Input.is_action_pressed("p_right")
	var up = Input.is_action_pressed("p_up")
	
	onGround = rayFloor.is_colliding()
	
	# Handle Movement
	gravity(delta)
	if left:
		flip(true)
		vel.x -= WALK_SPEED
	if right:
		flip(false)
		vel.x += WALK_SPEED
	vel.x *= 0.9
	
	if (right or left) and onGround:
		state = "Walk"
	
	if onGround and abs(vel.x) < 3:
		state = "idle"
	
	var motion = vel * delta
	move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)
	
	# Handle Jump
	if rayFloor.is_colliding() and up:
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