extends Area2D
@onready var death: AudioStreamPlayer2D = $SFX/Death
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	#body._hurted()
	print("game over")
	body.position.y -= 20
	body.get_node("CollisionShape2D").queue_free()
	body.is_dead = true
	timer.start()
	death.play() #Sound
	Engine.time_scale = 0.5

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
