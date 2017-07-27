extends KinematicBody2D
onready var vel = Vector2(0,0)
onready var rayWall = get_node("rayWall")
onready var rayFloor = get_node("rayFloor")
onready var rayForward = get_node("rayForward")
onready var idleTimer = get_node("IdleTimer")
onready var anim = get_node("AnimatedSprite")
onready var sfx = get_node("SamplePlayer")
onready var cs = get_node("CollisionShape2D")
onready var respawnTimer = get_node("RespawnTimer")

var health = 100

var WALK_SPEED = 50
var GRAV = 7
var goRight = true
var state = "run"

func _ready():
	set_fixed_process(true)
	rayWall.add_exception(self)
	rayWall.add_exception(get_node("../Player"))
	rayFloor.add_exception(self)
	rayForward.add_exception(self)
	pass

func _fixed_process(delta):
	if health <= 0 and state != "dead":
		state = "dead"
		#clear_shapes()
		anim.play("Dead")
		sfx.play("Die")
		main.skells_killed += 1
		respawnTimer.start()
	
	if state == "dead":
		cs.set_scale(Vector2(0.001,0.001))
		return
	
	vel.y += GRAV * delta
	
	if (rayWall.is_colliding() or !rayForward.is_colliding()) and state == "run":
		goRight = !goRight
		idleTimer.set_wait_time(randi()%3+1)
		idleTimer.start()
		state = "idle"
		
	
	if state == "idle":
		if anim.get_animation() != "Idle":
			anim.play("Idle")
		vel.x = 0
	
	if state == "run" and anim.get_animation() != "Run":
		anim.play("Run") 
	
	if goRight:
		set_scale(Vector2(1,1))
		if state == "run":
			vel.x = WALK_SPEED * delta
	if goRight == false:
		set_scale(Vector2(-1,1))
		if state == "run":
			vel.x = -WALK_SPEED * delta
	
	if rayFloor.is_colliding():
		vel.y = 0;
	move(vel)

func _on_IdleTimer_timeout():
	state = "run"
	idleTimer.stop()
	pass # replace with function body


func _on_RespawnTimer_timeout():
	state = "idle"
	health = 100
	idleTimer.start()
	cs.set_scale(Vector2(1,1))
	pass # replace with function body
