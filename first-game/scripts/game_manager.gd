extends Node

@onready var score_label: Label = %ScoreLabel
@onready var player: CharacterBody2D = $"../Player"
@onready var timer: Timer = $Timer

var score = 0
func _process(delta: float) -> void:
	score_label.global_position = player.global_position + Vector2(-30, -50)
func add_coin(amount := 1):
	SaveManager.coins += amount
	score_label.visible = true
	score_label.text = "Pièces: " + str(SaveManager.coins)
	timer.start()

func _on_timer_timeout() -> void:
	score_label.hide()
