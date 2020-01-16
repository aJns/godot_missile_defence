extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2
var target: Vector2
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(spawn_point_x: float, target: Vector2, speed: float):
	var translation_vector = Vector2(spawn_point_x, 0)
	self.translate(translation_vector)
	self.target = target
	self.speed = speed
	var pos = self.get_position()
	var v_diff = target - pos
	velocity = v_diff.normalized()*speed
	self.look_at(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance_to_target = self.get_position().distance_to(target) 
	if distance_to_target <= delta*speed:
		self.queue_free()
	
	self.translate(delta*velocity)
	
