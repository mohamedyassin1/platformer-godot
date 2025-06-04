extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	Global.end_level_popup = self

func _on_button_pressed():
	get_tree().reload_current_scene()
