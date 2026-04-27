extends Node2D

var dead = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(dead == true):
		animated_sprite.play("death")
		dead = false
