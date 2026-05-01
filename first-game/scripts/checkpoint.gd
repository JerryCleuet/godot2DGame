extends Area2D

func _on_body_entered(body):
	if body.name != "Player":
		return

	SaveManager.spawn_position = global_position
