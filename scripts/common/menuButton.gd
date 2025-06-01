extends Button

@onready var pause_menu = Global.pause_menu

func _ready():
	Global.main_menu_button = self
	
func toggle_pause():
	pause_menu.visible = !pause_menu.visible
	Global.is_paused = !Global.is_paused
	get_tree().paused = Global.is_paused

func _on_pressed():
	self.disabled = !self.disabled
	toggle_pause()
	
