extends Node2D

@onready var label = $Label
enum HINTS { MOVEMENT, DODGING, POWERUPS, DEFAULT }
@export var hint : HINTS
const AMOUNT_TO_MOVE_LABEL_BY = 9
var original_position
var moving_up_or_down = 1
var able_to_interact = false
# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = label.position
	label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if label.visible:
		if (label.position.y >= original_position.y):
			moving_up_or_down = 1
		elif (label.position.y <= (original_position.y - AMOUNT_TO_MOVE_LABEL_BY)):
			moving_up_or_down = -1
		label.position.y = label.position.y - (0.1*moving_up_or_down)
	if able_to_interact and Input.is_action_just_pressed("interact"):
		match hint:
			HINTS.MOVEMENT:
				Global.hint_menu.set_label(["Move with WASD or arrow keys"])
			HINTS.DODGING:
				Global.hint_menu.set_label(["Dodge enemies with Q"])
			HINTS.POWERUPS:
				Global.hint_menu.set_label(["Power-ups:", 
				"1. Super-Speed",
				"2. Super-Jump"])
			HINTS.DEFAULT:
				Global.hint_menu.set_label(["Collect all the coins!"])
		Global.hint_menu.visible = true
		
func _on_body_entered(body):
	if "Player" in body.name:
		label.visible = true
		able_to_interact = true
		if !Global.main_menu_button.disabled:
			Global.main_menu_button.disabled = !Global.main_menu_button.disabled

func _on_body_exited(body):
	label.position = original_position
	if "Player" in body.name:
		label.visible = false
		able_to_interact = false
		if Global.main_menu_button.disabled:
			Global.main_menu_button.disabled = !Global.main_menu_button.disabled
		Global.hint_menu.visible = false
