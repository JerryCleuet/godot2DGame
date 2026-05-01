extends Area2D
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var coin_id: String

func _ready():
	if SaveManager.collected_coins.has(coin_id):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if SaveManager.collected_coins.has(coin_id):
		return
	SaveManager.collected_coins[coin_id] = true
	game_manager.add_coin(1)
	animation_player.play("pickup")
	
