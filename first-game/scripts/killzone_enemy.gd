extends Area2D
@onready var death: AudioStreamPlayer2D = $SFX/Death
@onready var timer: Timer = $Timer
@onready var slime: Node2D = $".."

func _on_body_entered(body: Node2D) -> void:
	if not body.hasASword:
		print(body.hasASword)
		print("game over")
		body.get_node("CollisionShape2D").queue_free()
		body.is_dead = true
		timer.start()
		death.play() #Sound
		Engine.time_scale = 0.5
	else:
		slime.dead = true
		get_parent().queue_free()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
