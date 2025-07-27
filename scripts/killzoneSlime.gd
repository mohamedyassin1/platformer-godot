extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	# If the player is dodging/rolling, they should be able to dodge the slime
	if not Global.player.is_rolling:
		print("You died!")
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
