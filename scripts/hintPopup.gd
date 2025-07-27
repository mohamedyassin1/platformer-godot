extends CanvasLayer

var hints = []
@onready var label = $Panel/Label


func _ready():
	self.visible = false
	Global.hint_menu = self
	
func _on_button_pressed():
	self.visible = false

func set_label(passed_hints):
	hints = passed_hints
	label.text = ""
	for i in range(hints.size()):
		label.text += "\n" + hints[i] + "\n"
		
