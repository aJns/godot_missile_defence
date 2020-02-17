extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GameLogic: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("pause_game"):
		if get_tree().paused:
			GameLogic.start_game()
		else:
			GameLogic.pause_game()


func inject_game_logic_ref(game: Node):
	GameLogic = game


func _on_new_game_pressed():
	GameLogic.reset_game()
	GameLogic.start_game()
