extends Node

@onready var score_label: Label = %ScoreLabel
@onready var player: CharacterBody2D = $"../Player"
@onready var timer: Timer = $Timer

var score = 0


func add_point():
	score_label.visible = true
	score += 1
	print(score)
	score_label.text = "Points : " + str(score)
	timer.start()


func _on_timer_timeout() -> void:
	score_label.hide()
