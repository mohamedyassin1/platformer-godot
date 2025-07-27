extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var roll_timer = $RollTimer
@onready var powerup_timer = $PowerupTimer

var SPEED = 130.0
var JUMP_VELOCITY = -300.0
const ROLL_BOOST = 1.25
const MAX_JUMPS = 2

var is_rolling = false
var roll_direction = 0 
var jump_count = 0

enum POWERUPS {
	SUPER_SPEED,
	SUPER_JUMP,
}

func _physics_process(delta):
	
	# Movement direction if the player
	var direction = Input.get_axis("move_left", "move_right")
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0 # Reset jump count when on floor

	# When still rolling:
	if is_rolling:
		velocity.x = (SPEED * ROLL_BOOST) * roll_direction # Speed boost when rolling
		move_and_slide() # To ensure character keeps moving while rolling
		return # Return so we don't handle other actions (jump, move left/right) while rolling

	# Jump
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		if (jump_count > 0):
			$JumpParticles.emitting = true
			velocity.y = JUMP_VELOCITY/1.5 # Less intense 2nd jump
		else:
			velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Dodge/Roll
	if Input.is_action_just_pressed("dodge"): 
		is_rolling = true
		roll_timer.start()

		# Determine roll direction:
		if direction != 0:
			roll_direction = direction
		else:
			# If standing still, use sprite facing direction
			roll_direction = -1 if animated_sprite_2d.flip_h else 1

		animated_sprite_2d.play("roll")
		move_and_slide()
		return

	# Flip sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _ready():
	Global.player = self
	
# User a timer node to track rolling
func _on_roll_timer_timeout():
	is_rolling = false

func powerup():
	var powerups = POWERUPS.values()
	var chosen_powerup = powerups[randi() % powerups.size()]
	match chosen_powerup:
		POWERUPS.SUPER_SPEED:
			SPEED = 200
		POWERUPS.SUPER_JUMP:
			JUMP_VELOCITY = -400
	if (powerup_timer.is_stopped()):
		powerup_timer.start()
	else:
		var current_time = powerup_timer.get_time_left()
		powerup_timer.stop()
		powerup_timer.set_wait_time(current_time + 5)
		powerup_timer.start()

func _on_powerup_timer_timeout():
	SPEED = 130.0
	JUMP_VELOCITY = -300
