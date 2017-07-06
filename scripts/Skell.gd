extends KinematicBody2D
onready var vel = Vector2(0,0)
onready var rayWall = get_node("rayWall")
onready var rayFloor = get_node("rayFloor")
onready var rayForward = get_node("rayForward")

var WALK_SPEED = 50
var GRAV = 7
var goRight = true

func _ready():
	set_fixed_process(true)
	rayWall.add_exception(self)
	rayFloor.add_exception(self)
	rayForward.add_exception(self)
	pass

func _fixed_process(delta):
	vel.y += GRAV * delta
	
	if rayWall.is_colliding() or !rayForward.is_colliding():
		goRight = !goRight
		
	if goRight:
		set_scale(Vector2(1,1))
		vel.x = WALK_SPEED * delta
	if goRight == false:
		set_scale(Vector2(-1,1))
		vel.x = -WALK_SPEED * delta
	
	if rayFloor.is_colliding():
		vel.y = 0;
	move(vel)