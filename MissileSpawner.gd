extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawn_per_minute = 120
var time_between_spawns_s = 60/spawn_per_minute
var time_since_last_spawn = time_between_spawns_s
var missile_speed = 100

var spawn_half_circle_r = 1000
var spawn_half_circle_center = Vector2(500, 0)
var spawn_pt_x_range = [500-spawn_half_circle_r, 500+spawn_half_circle_r]

func half_circle_y(x):
	# Invariant: x must be in [c-r, c+r]
	var r = spawn_half_circle_r
	var c = spawn_half_circle_center.x
	var y = sqrt(pow(r,2)-pow(x-c, 2))
	return -y # minus because 2d coordinates: up is down

var rng = RandomNumberGenerator.new()
var missile = preload("res://Missile.tscn") # Will load when parsing the script.

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_last_spawn += delta
	
	if time_since_last_spawn > time_between_spawns_s:
		spawn_missile()
		time_since_last_spawn = 0

func spawn_missile():
	var spawn_y_offset = 300
	var node = missile.instance()
	var target = spawn_half_circle_center
	target.y += spawn_y_offset
	var x = rng.randf_range(spawn_pt_x_range[0], spawn_pt_x_range[1])
	var spawn_point = Vector2(x, half_circle_y(x)+spawn_y_offset)
	node.init(spawn_point, target, missile_speed)
	add_child(node)