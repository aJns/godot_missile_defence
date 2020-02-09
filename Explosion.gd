extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var explo_range = 50
var explosion_timer = 2
var dealt_damage = false


func _ready():
	var rot = rand_range(0, 360)
	set_rotation_degrees(rot)
	get_node("AnimationPlayer").play("explosion")


func deal_damage():
	dealt_damage = true
	
	var projectiles = get_tree().get_nodes_in_group("projectiles")
	for p in projectiles:
		if is_instance_valid(p):
			if self.position.distance_to(p.position) < explo_range:
				p.explode()
	
	var buildings = get_tree().get_nodes_in_group("buildings")
	for b in buildings:
		if is_instance_valid(b):
			b.take_damage(self.position, explo_range)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dealt_damage:
		deal_damage()
	explosion_timer -= delta
	if explosion_timer < 0:
		self.queue_free()
