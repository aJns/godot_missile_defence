extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var should_fade = false
const FADE_TIME = 10
var fade_timer = FADE_TIME
var current_end_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = -25 # Draw this behind missiles and city, but in front of the Ground (-100)
	width = 2
	default_color = Color(0.54, 0.66, 0.69, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_fade:
		fade_timer -= delta
		
		var alpha = fade_timer/FADE_TIME
		default_color = Color(0.54, 0.66, 0.69, alpha)
		
		if fade_timer <= 0:
			self.queue_free()


func fade_away():
	should_fade = true


func set_start_pos(start_pos: Vector2):
	current_end_pos = start_pos


func update_end_pos(end_pos: Vector2):
	if current_end_pos.distance_to(end_pos) > 1:
		add_point(end_pos)
		current_end_pos = end_pos
