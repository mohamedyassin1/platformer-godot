extends CanvasLayer

func _on_resume_button_pressed():
	get_tree().paused = false
	Global.is_paused = false
	self.visible = false
	Global.main_menu_button.disabled = false

func _ready():
	self.visible = false
	Global.pause_menu = self
