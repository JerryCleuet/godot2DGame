extends Node

@onready var score_label: Label = %ScoreLabel
@onready var player: CharacterBody2D = $"../Player"
@onready var timer: Timer = $Timer

var score = 0

func add_coin(amount := 1):
	SaveManager.coins += amount
	score_label.visible = true
	score_label.text = "Pièces: " + str(SaveManager.coins)
	timer.start()

func _on_timer_timeout() -> void:
	score_label.hide()
