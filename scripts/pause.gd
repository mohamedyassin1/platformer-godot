extends CanvasLayer

func update_pause_menu():
	get_tree().paused = false
	Global.is_paused = false
	self.visible = false
	
func _on_resume_button_pressed():
	update_pause_menu()
	Global.main_menu_button.disabled = false

func _ready():
	self.visible = false
	Global.pause_menu = self

func _on_exit_to_main_menu_pressed():
	update_pause_menu()
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
