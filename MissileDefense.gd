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
	get_node("City").reset()
	get_node("DefenseMissileLauncher").reset()
	get_node("MissileSpawner").reset()
	
	var removables = get_tree().get_nodes_in_group("removables")
	
	for r in removables:
		r.queue_free()


func start_game():
	print("Start game")
	GameMenu.hide()
	get_tree().paused = false


func pause_game():
	print("Pause game")
	get_tree().paused = true
	GameMenu.show()
