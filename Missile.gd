extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = Vector2(0, 2)
var acceleration: Vector2
var velocity: Vector2
var has_target = false
var target: Vector2
var max_speed: float

var exploding = false # State machine would probably be better
var explosion_timer = 5

var missile_sprite: Node2D
var explosion_sprite: Node2D

const MAX_DST_ORIG = 10000
const GROUND_LEVEL = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# TODO: Do Missile init better. Plan:
#	Some parameters as in some structure
#		Starting: Position, velocity,
#		max_speed, acceleration
#	A target 
	
func init(spawn_point: Vector2, target_direction: Vector2, max_speed: float, target: Vector2):
	missile_sprite = get_node("MissileSprite")
	explosion_sprite = get_node("ExplosionSprite")
	print("Spawn point: ", spawn_point)
	self.translate(spawn_point)
	self.max_speed = max_speed
	var pos = self.get_position()
	var v_diff = target_direction - pos
	velocity = v_diff.normalized()*(max_speed/2)
	acceleration = velocity/10
	self.look_at(target_direction)
	self.target = target

func limit_velocity(vel, max_length):
	if vel.length() > max_length:
		return vel.normalized()*max_length
	else:
		return vel
		
func init_explosion():
	# I guess we want to signal to MissileSpawner that we exploded
	# and check all missiles if they're within the explosion radius
	get_node("MissileSprite").hide()
	explosion_sprite.show()
	exploding = true
	
func process_explosion(delta):
	explosion_timer -= delta
	explosion_sprite.rotate(0.5*delta)
	if explosion_timer < 0:
		self.queue_free()

func check_state(delta):
	if self.position.length() > MAX_DST_ORIG:
		self.queue_free()

	if self.position.y > GROUND_LEVEL:
		init_explosion()
	# TODO: explode if colliding with city, explosion, or ground
	if has_target:
		if self.position.distance_to(target) < min(1, velocity.length()*delta):
			init_explosion()


func move(delta):
	velocity += gravity + acceleration
	velocity = limit_velocity(velocity, max_speed)
	var speed = velocity.length()
	
	self.translate(delta*velocity)
	self.look_at(position+velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_state(delta)
	if not exploding:
		move(delta)
	else:
		process_explosion(delta)
