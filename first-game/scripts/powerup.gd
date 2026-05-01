extends Node2D

@onready var game_manager: Node = %GameManager
@onready var powerup_label: Label = $"../../Labels/PowerupLabel"
@onready var power_up_info: Label = $"../../Labels/PowerUpInfo"

var player_in_range = false
var dialogue_index = 0
var state = "dialogue" # dialogue / shop / idle

var player_ref = null

var messages = [
	"Salut voyageur...",
	"J'ai quelque chose d'intéressant pour toi.",
	"Un pouvoir spécial... mais ça coûte 50 pièces.",
	"Appuie sur O pour acheter ou N pour refuser."
]

func _ready() -> void:
	powerup_label.text = "Appuie sur P pour interagir"
	power_up_info.hide()


# --- Détection joueur ---
func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Player":
		player_in_range = true
		player_ref = body
		dialogue_index = 0
		state = "idle"
		powerup_label.text = "Appuie sur P pour parler"


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		player_ref = null
		state = "idle"
		powerup_label.text = ""
		power_up_info.hide()


# --- Input joueur ---
func _input(event):
	if not player_in_range:
		return

	# Interaction principale
	if event.is_action_pressed("powerup_pnj"):
		start_dialogue()

	# Acheter power-up
	if state == "shop" and event.is_action_pressed("accept"): # O
		try_buy_powerup()

	# Refuser
	if state == "shop" and event.is_action_pressed("refuse"): # N
		cancel_shop()


# --- Dialogue ---
func start_dialogue():
	power_up_info.hide()
	state = "dialogue"

	if dialogue_index < messages.size():
		powerup_label.text = messages[dialogue_index]
		dialogue_index += 1

		# dernière ligne → passage boutique
		if dialogue_index >= messages.size():
			state = "shop"
	else:
		state = "shop"
		powerup_label.text = "Acheter power-up ? (O/N)"


# --- Achat ---
func try_buy_powerup():
	if game_manager.score < 50:
		powerup_label.text = "Pas assez de pièces..."
		return

	# transaction
	game_manager.score -= 50
	game_manager.score_label.text = "Points : " + str(game_manager.score)

	# effet joueur
	print(player_ref)
	if player_ref != null:
		player_ref.power_up = true

	powerup_label.text = "POWER-UP ACHETÉ !"
	state = "idle"


# --- Annulation ---
func cancel_shop():
	dialogue_index = 0
	state = "idle"
	powerup_label.text = "Appuie sur P pour interagir"
