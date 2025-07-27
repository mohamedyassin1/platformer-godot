extends CanvasLayer


func _ready():
	Global.real_main_menu = self


func _on_play_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
