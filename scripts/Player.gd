extends RigidBody2D

onready var rayFloor = get_node("rayFloor")
onready var onGround = false
onready var vel = Vector2(0,0)
onready var WALK_SPEED = 1000
onready var JUMP_SPEED = 30

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var left = Input.is_action_pressed("p_left")
	var right = Input.is_action_pressed("p_right")
	var up = Input.is_action_pressed("p_up")
	
	# Handle movement
	vel.y = self.get_linear_velocity().y
	vel.x *= 0.9
	if(left and not right):
		vel.x -= WALK_SPEED * delta
	if(right and not left):
		vel.x += WALK_SPEED * delta
	if up and rayFloor.is_colliding():
		vel.y -= JUMP_SPEED
	self.set_linear_velocity(vel)
	
	# Check if on ground
	if rayFloor.is_colliding():
		onGround = true
	else:
		onGround = false