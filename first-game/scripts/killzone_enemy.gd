extends Area2D

@onready var slime: Node2D = get_parent()


func _on_body_entered(body: Node2D) -> void:
	if body == null:
		return

	if not body.name == "Player":
		return

	if body.has_method("on_slime_hit"):
		body.on_slime_hit(slime)
