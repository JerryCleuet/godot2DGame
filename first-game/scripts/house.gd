extends Area2D
@onready var enter_label: Label = $EnterLabel

var player_in_range := false
var player :CharacterBody2D = null

func _ready():
	enter_label.visible = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_in_range = true
		enter_label.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		player = null
		enter_label.visible = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		change_scene()

func change_scene():
	SaveManager.position = player.global_position
	get_tree().change_scene_to_file("res://scenes/interior.tscn")
