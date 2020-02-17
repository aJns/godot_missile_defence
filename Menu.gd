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

func inject_game_logic_ref(game: Node):
	GameLogic = game


func _on_new_game_pressed():
	GameLogic.reset_game()
	GameLogic.start_game()
