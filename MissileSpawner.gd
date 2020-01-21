extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawn_per_minute = 60
var time_between_spawns_s = 60/spawn_per_minute
var time_since_last_spawn = time_between_spawns_s

const AVG_MISSILE_SPEED = 100
const MSL_SPEED_VAR = 30

const WINDOW_CEIL = 0
const WINDOW_WIDTH = 1024

const SPAWN_Y = WINDOW_CEIL - 100
const SPAWN_LEFT = -300
const SPAWN_RIGHT = WINDOW_WIDTH + 300

const CITY_Y = 500
const CITY_LEFT = 300
const CITY_RIGHT = 800


var rng = RandomNumberGenerator.new()
var missile = preload("res://Projectile.tscn") # Will load when parsing the script.


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
	var node = missile.instance()
	
	var target = Vector2(0, CITY_Y)
	target.x = rng.randf_range(CITY_LEFT, CITY_RIGHT)
	
	node.position.y = SPAWN_Y
	node.position.x = rng.randf_range(SPAWN_LEFT, SPAWN_RIGHT)
	var flight_dir = node.position.direction_to(target)
	
	var speed = rng.randf_range(AVG_MISSILE_SPEED-MSL_SPEED_VAR, AVG_MISSILE_SPEED+MSL_SPEED_VAR)
	node.init(flight_dir, speed)
	add_child(node)