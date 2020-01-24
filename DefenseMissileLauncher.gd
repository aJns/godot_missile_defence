extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const missile_speed = 100
var missile_scene = preload("res://Projectile.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_missile_shoot"):
		var target = get_viewport().get_mouse_position()
		var msl = missile_scene.instance()
		
		msl.position = self.position
		var flight_dir = msl.position.direction_to(target)
		msl.init(flight_dir, 100, target, true)
		get_node("/root").add_child(msl) # For some reason if add as child to missile_defense to missile is invisible
		# TODO: find out why ^^