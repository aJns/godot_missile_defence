extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const CITY_FULL_HP = 10
var city_life = CITY_FULL_HP
var sprite_node: Sprite
var label_node: Label

const CITY_HP_STR = "City HP: %s"

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_node = get_node("city_sprite")
	label_node = get_node("health_label")
	label_node.text = CITY_HP_STR % city_life


func reset():
	city_life = CITY_FULL_HP
	label_node.text = CITY_HP_STR % city_life


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if city_life <= 0:
		get_node("/root/Game").game_over()


func take_damage(explosion_position: Vector2, explosion_radius: float):
	var exp_pos_local = explosion_position - self.position
	if sprite_node.get_rect().has_point(exp_pos_local):
		city_life -= 1
		label_node.text = CITY_HP_STR % city_life
