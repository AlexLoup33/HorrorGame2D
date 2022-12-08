extends Control

enum STATE{
	Lock,
	Unlock,
}

func _ready():
	for n in $LevelContainer:
		pass

func _on_ExitButton_pressed():
	get_tree().change_scene("res://scene/Menu/MainMenu.tscn")
