extends Area2D

@onready var result_label: Label = $"../Labels/result_label"
@onready var game_manager: Node = %GameManager

var spinning := false


func _ready() -> void:
	input_pickable = true
	result_label.visible = false


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not spinning:
		play_casino()


func play_casino():

	if SaveManager.coins <= 0:
		show_result("Pas assez de pièces !")
		return

	spinning = true

	SaveManager.coins -= 1

	result_label.visible = true
	result_label.text = "..."

	# petit suspense
	await get_tree().create_timer(0.5).timeout

	var chance = randf()

	if chance <= 0.15:
		SaveManager.coins *= 2
		show_result("GAGNÉ !(" + str(chance) + "/0.15)")
	else:
		show_result("Perdu... (" + str(chance) + "/0.2)")


func show_result(text):

	result_label.text = text

	# update score
	game_manager.score_label.text = "Points : " + str(SaveManager.coins)
	game_manager.score_label.show()
	game_manager.timer.start()

	await get_tree().create_timer(1.5).timeout

	result_label.visible = false
	spinning = false
