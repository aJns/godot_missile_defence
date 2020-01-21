extends Node2D

class_name Projectile

var velocity: Vector2

const MAX_DST_ORIG = 10000
const GROUND_LEVEL = 550

var explosion = preload("res://Explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func init(flight_direction: Vector2, speed: float):
	self.velocity = flight_direction.normalized()*speed
		
		
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
	self.translate(delta*velocity)
	self.look_at(position+velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_state(delta)
	move(delta)
