extends Area2D


@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound_effect = $PowerupSound
@export var scale_factor = 0.003

var growing = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.scale += Vector2(scale_factor * growing, scale_factor * growing)
	if sprite.scale <= Vector2(0.3,0.3):
		growing = 1
	elif sprite.scale >= Vector2(0.9,9):
		growing = -1
		
func _on_body_entered(body):
	if "Player" in body.name:
		collision.set_deferred("disabled", true)
		sprite.visible = false
		sound_effect.play()
		body.powerup()
