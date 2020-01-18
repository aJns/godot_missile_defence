extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = Vector2(0, 2)
var acceleration: Vector2
var velocity: Vector2
var target: Vector2
var max_speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(spawn_point: Vector2, target: Vector2, max_speed: float):
	print("Spawn point: ", spawn_point)
	self.translate(spawn_point)
	self.target = target
	self.max_speed = max_speed
	var pos = self.get_position()
	var v_diff = target - pos
	velocity = v_diff.normalized()*(max_speed/2)
	acceleration = velocity/10
	self.look_at(target)

func limit_velocity(vel, max_length):
	if vel.length() > max_length:
		return vel.normalized()*max_length
	else:
		return vel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += gravity + acceleration
	velocity = limit_velocity(velocity, max_speed)
	var speed = velocity.length()
	if self.position.y > 400:
		self.queue_free()
	
	self.translate(delta*velocity)
	self.look_at(position+velocity)	
