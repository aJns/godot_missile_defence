extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var explosion_timer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	explosion_timer -= delta
	rotate(0.5*delta)
	if explosion_timer < 0:
		self.queue_free()
