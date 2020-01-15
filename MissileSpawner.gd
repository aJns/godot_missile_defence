extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawn_per_minute = 6
var time_between_spawns_s = 60/spawn_per_minute
var time_since_last_spawn = time_between_spawns_s

var rng = RandomNumberGenerator.new()
var missile = preload("res://Missile.tscn") # Will load when parsing the script.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_last_spawn += delta
	
	if time_since_last_spawn > time_between_spawns_s:
		spawn_missile()
		time_since_last_spawn = 0

func spawn_missile():
	var node = missile.instance()
	var target = Vector2(500, 600)
	var speed = 10
	var spawn_point_x = rng.randf_range(100, 900)
	node.init(spawn_point_x, target, speed)
	add_child(node)