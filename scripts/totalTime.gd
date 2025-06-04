extends Label

func _ready():
	Global.level_over_menu_timer = self
	
func update_time():
	self.text = Global.level_timer.text
