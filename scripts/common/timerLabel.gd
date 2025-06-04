extends Label

var elapsed_time = 0.0 

func _ready():
	Global.level_timer = self

func update_timer_label():
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	var minutes_str = "%02d" % minutes
	var seconds_str = "%02d" % seconds
	self.text = "Time: " + minutes_str + ":" + seconds_str
	
func _process(delta):
	elapsed_time += delta
	update_timer_label()
