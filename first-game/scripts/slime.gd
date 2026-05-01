extends Node2D

const SPEED = 40

var direction := 1
var dead := false

@onready var ray_right: RayCast2D = $RayCastRight
@onready var ray_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	if dead:
		return

	if ray_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	position.x += direction * SPEED * delta

	animated_sprite.play("walk")


func _on_body_entered(body):
	if dead:
		return

	if body.name == "Player":
		body.on_slime_hit(self)


func die():
	if dead:
		return

	dead = true
	animated_sprite.play("death")

	await animated_sprite.animation_finished
	queue_free()
