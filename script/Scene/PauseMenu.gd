extends Control

var is_paused = false setget set_is_paused

func _ready():
	visible = is_paused
	get_tree().paused = is_paused

func _unhandled_input(event):
	if event.is_action_pressed("Escape"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_ResumeButton_pressed():
	self.is_paused = false

func _on_QuitToMenu_pressed():
	get_tree().change_scene("res://scene/Menu/MainMenu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
