extends Node2D


var grav_a = Vector2(0, 2)
var velocity: Vector2
var engine_thrust: float
var max_speed: float

const MAX_DST_ORIG = 10000
const GROUND_LEVEL = 500

var explosion = preload("res://Explosion.tscn")

class_name Projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func init(start_velocity: Vector2, engine_thrust: float, max_speed: float):
	self.velocity = start_velocity
	self.engine_thrust = engine_thrust
	self.max_speed = max_speed
	

func limit_velocity(vel, max_length):
	if vel.length() > max_length:
		return vel.normalized()*max_length
	else:
		return vel
		
		
func explode():
	var exp_node = explosion.instance()
	exp_node.position = self.position
	get_node("/root").add_child(exp_node)
	self.queue_free()


func check_state(delta):
	if self.position.length() > MAX_DST_ORIG:
		self.queue_free()

	if self.position.y > GROUND_LEVEL:
		explode()


func move(delta):
	velocity += grav_a + (engine_thrust*velocity.normalized())
	velocity = limit_velocity(velocity, max_speed)
	var speed = velocity.length()
	
	self.translate(delta*velocity)
	self.look_at(position+velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_state(delta)
	move(delta)
