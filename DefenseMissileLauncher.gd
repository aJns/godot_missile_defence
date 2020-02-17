extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const missile_speed = 100
var missile_scene = preload("res://Projectile.tscn")


enum MSL_COLOR{
	BLUE,
	RED
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("game_missile_shoot"):
		# TODO: Don't shoot if game is paused
		shoot_missile_at(event.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func reset():
	# TODO: reset stuff
	pass


func shoot_missile_at(target: Vector2):
	var msl = missile_scene.instance()
	
	msl.position = self.position
	var flight_dir = msl.position.direction_to(target)
	get_node("/root").add_child(msl) # For some reason if add as child to missile_defense to missile is invisible
	# TODO: find out why ^^
	msl.init(flight_dir, 100, target, true)
	msl.set_sprite_color(MSL_COLOR.BLUE)
