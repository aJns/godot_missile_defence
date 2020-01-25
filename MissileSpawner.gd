extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var missiles_spawned = 0
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
const SPAWN_MIDDLE = (SPAWN_LEFT+SPAWN_RIGHT)/2
const SPAWN_BIAS = (SPAWN_RIGHT-SPAWN_LEFT)/5

const CITY_Y = 500
const CITY_LEFT = 200
const CITY_RIGHT = 800
const CITY_MIDDLE = (CITY_LEFT+CITY_RIGHT)/2
const CITY_BIAS = (CITY_RIGHT-CITY_LEFT)/5 # "Biases" the normal distribution of the target x


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
		missiles_spawned += 1
		time_since_last_spawn = 0


func spawn_missile():
	var node = missile.instance()
	
	var city_distr = rng.randfn(0, 0.5)
	var target = Vector2(0, CITY_Y)
	target.x = CITY_MIDDLE + city_distr*CITY_BIAS
		
	var spawn_distr = rng.randfn(0, 1)
	node.position.y = SPAWN_Y
	node.position.x = SPAWN_MIDDLE + spawn_distr*SPAWN_BIAS
	var flight_dir = node.position.direction_to(target)
	
	var speed = rng.randf_range(AVG_MISSILE_SPEED-MSL_SPEED_VAR, AVG_MISSILE_SPEED+MSL_SPEED_VAR)
	add_child(node)
	node.init(flight_dir, speed, Vector2(9999, 9999), false)