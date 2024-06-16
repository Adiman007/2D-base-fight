extends Control


func _ready():
	$StartButton.connect("pressed", _on_StartButton_pressed)
	$QuitButton.connect("pressed", _on_QuitButton_pressed)


func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
