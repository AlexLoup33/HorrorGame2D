extends Control

var PATH_FILE = "users://save/OptionsMenu.dat"

func _ready():
	load_save()

func load_save():
	var file = File.new()
	file.open(PATH_FILE, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content

func savefile(content):
	var file = File.new()
	file.open(PATH_FILE, File.WRITE)
	file.store_string(content)
	file.close()

func _on_Play_pressed():
	get_tree().change_scene("res://scene/Level/Tutorial.tscn")

func _on_Level_pressed():
	get_tree().change_scene("res://scene/Menu/LevelMenu.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scene/Menu/OptionMenu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
