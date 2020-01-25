extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var should_fade = false
var fade_timer = 10
var current_end_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_fade:
		fade_timer -= delta
		
		if fade_timer < 0:
			self.queue_free()


func fade_away():
	should_fade = true


func set_start_pos(start_pos: Vector2):
	current_end_pos = start_pos


func update_end_pos(end_pos: Vector2):
	if current_end_pos.distance_to(end_pos) > 1:
		add_point(end_pos)
		current_end_pos = end_pos