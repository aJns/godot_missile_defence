extends CanvasLayer


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


func hide():
	get_node("new_game").visible = false
	get_node("cont").visible = false
	get_node("title").visible = false


func show():
	get_node("new_game").visible = true
	get_node("cont").visible = true
	get_node("title").visible = true


func _on_new_game_pressed():
	GameLogic.reset_game()
	GameLogic.start_game()


func _on_cont_pressed():
	GameLogic.start_game()
