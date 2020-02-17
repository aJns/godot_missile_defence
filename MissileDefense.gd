extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GameMenu: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not GameMenu:
		GameMenu = get_node("Menu")
		GameMenu.inject_game_logic_ref(self)
		get_tree().paused = true


func game_over():
	get_node("GameOverLabel").visible = true



func reset_game():
	# TODO
	# Reset city health
	# Remove all missiles and explosions
	# Reset missile spawner and defense missile launcher
	pass


func start_game():
	print("Start game")
	GameMenu.visible = false
	get_tree().paused = false


func pause_game():
	print("Pause game")
	get_tree().paused = true
	GameMenu.visible = true
