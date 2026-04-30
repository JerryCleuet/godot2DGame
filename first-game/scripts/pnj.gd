extends Node2D


var player_in_range = false
	
func _on_area_2d_body_entered(body: Node2D):
	print(body.name)
	if body.name == "Player":
		player_in_range = true
		print(player_in_range)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
