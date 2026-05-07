extends Node2D
@onready var exit_label: Label = $ExitLabel

var player_in_range := false
var player :CharacterBody2D = null

func _ready():
	exit_label.visible = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_in_range = true
		exit_label.visible = true

func _on_body_exited(body):
	print("ouioui")
	if body.is_in_group("Player"):
		player_in_range = false
		player = null
		exit_label.visible = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		change_scene()

func change_scene():
	SaveManager.insidePosition = player.global_position
	SaveManager.spawn_position = SaveManager.position
	get_tree().change_scene_to_file("res://scenes/game.tscn")
