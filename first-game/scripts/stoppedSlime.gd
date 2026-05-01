extends Node2D

var dead := false
@export var slime_id: String
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var score_label: Label = %ScoreLabel


func _ready():
	if SaveManager.dead_slimes.has(slime_id):
		queue_free()
		return

	animated_sprite.play("idle")


func die():
	if dead:
		return

	dead = true

	SaveManager.dead_slimes[slime_id] = true
	SaveManager.coins += 1

	score_label.visible = true
	score_label.text = "Pièces : " + str(SaveManager.coins)

	_hide_score_later()

	animated_sprite.play("death")
	await animated_sprite.animation_finished
	queue_free()
	
func _hide_score_later():
	await get_tree().create_timer(0.5).timeout
	score_label.visible = false
