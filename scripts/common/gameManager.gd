extends Node

@onready var pause_menu = Global.pause_menu
@onready var total_coins = get_parent().get_node("Coins").get_child_count()
var score = 0

func add_point():
	score += 1
	Global.score_label.text = "You collected " + str(score) + " coins"
	if score == total_coins:
		completed_level()

func completed_level():
	Global.level_over_menu_timer.update_time()
	Global.end_level_popup.visible = true

func toggle_pause():
	pause_menu.visible = !pause_menu.visible
	Global.main_menu_button.disabled = !Global.main_menu_button.disabled
	Global.is_paused = !Global.is_paused
	get_tree().paused = Global.is_paused
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Typically Esc
		toggle_pause()
	
	
