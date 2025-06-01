extends Node

@onready var score_label = $ScoreLabel

@onready var pause_menu = Global.pause_menu

var score = 0
func add_point():
	score += 1
	Global.score_label.text = "You collected " + str(score) + " coins"

func toggle_pause():
	pause_menu.visible = !pause_menu.visible
	Global.main_menu_button.disabled = !Global.main_menu_button.disabled
	Global.is_paused = !Global.is_paused
	get_tree().paused = Global.is_paused
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Typically Esc
		toggle_pause()
	
	
