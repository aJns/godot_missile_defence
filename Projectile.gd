extends Node2D

class_name Projectile

var velocity: Vector2

var speed: float
var target: Vector2

const MAX_DST_ORIG = 10000
const GROUND_LEVEL = 550

var explosion = preload("res://Explosion.tscn")

var red_sprite = preload("res://missile_red.png")
var blue_sprite = preload("res://missile_blue.png")

var draw_target: bool
var target_sprite: Sprite
var target_scene = preload("res://Target.tscn")

var chemtrail_scene = preload("res://Chemtrail.tscn")
var chemtrail: Line2D

var is_enemy = false

enum MSL_COLOR{
	BLUE,
	RED
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func init(flight_direction: Vector2, speed: float, target: Vector2, draw_target: bool):
	self.speed = speed
	self.velocity = flight_direction.normalized()*speed
	self.target = target
	self.draw_target = draw_target
	
	self.chemtrail = chemtrail_scene.instance()
	get_node("/root").add_child(chemtrail)
	chemtrail.set_start_pos(self.position)
		
		
func set_sprite_color(color):
	if color == MSL_COLOR.BLUE:
		get_node("missile").set_texture(blue_sprite)
	if color == MSL_COLOR.RED:
		get_node("missile").set_texture(red_sprite)
		self.is_enemy = true
		
func explode():
	if self.is_enemy:
		var city = get_node("/root/Game/City")
		city.enemy_missile_destroyed()
	
	self.remove_from_group("projectiles")	# Gotta do this, so we don't reference this missile anymore
	var exp_node = explosion.instance()
	exp_node.position = self.position
	get_node("/root").add_child(exp_node)
	if target_sprite:
		target_sprite.queue_free()
	chemtrail.fade_away()
	self.queue_free()


func check_state(delta):
	if self.position.length() > MAX_DST_ORIG:
		self.queue_free()

	if self.position.y > GROUND_LEVEL:
		explode()
	
	if self.position.distance_to(target) < max(speed*delta, 1):
		explode()


func move(delta):
	self.translate(delta*velocity)
	self.look_at(position+velocity)
	self.chemtrail.update_end_pos(self.position)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draw_target:
		target_sprite = target_scene.instance()
		get_node("/root").add_child(target_sprite)
		target_sprite.position = target
		draw_target = false
		
	check_state(delta)
	move(delta)
