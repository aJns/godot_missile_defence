extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = Vector2(0, 2)
var acceleration: Vector2
var velocity: Vector2
var has_target = false
var target: Vector2
var max_speed: float

var missile_sprite: Node2D

const MAX_DST_ORIG = 10000
const GROUND_LEVEL = 500

var explosion = preload("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# TODO: Do Missile init better. Plan:
#	Some parameters as in some structure
#		Starting: Position, velocity,
#		max_speed, acceleration
#	A target 
	
func init(spawn_point: Vector2, target_direction: Vector2, max_speed: float, target: Vector2):
	missile_sprite = get_node("MissileSprite")
	print("Spawn point: ", spawn_point)
	self.translate(spawn_point)
	self.max_speed = max_speed
	var pos = self.get_position()
	var v_diff = target_direction - pos
	velocity = v_diff.normalized()*(max_speed/2)
	acceleration = velocity/10
	self.target = target

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
	# TODO: explode if colliding with city, explosion, or ground
	if has_target:
		if self.position.distance_to(target) < min(1, velocity.length()*delta):
			explode()


func move(delta):
	velocity += gravity + acceleration
	velocity = limit_velocity(velocity, max_speed)
	var speed = velocity.length()
	
	self.translate(delta*velocity)
	self.look_at(position+velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_state(delta)
	move(delta)
