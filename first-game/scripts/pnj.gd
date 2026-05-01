extends Node2D
@onready var casino_text: Label = $"../../Labels/CasinoText"
@onready var casino_info_text: Label = $"../../Labels/CasinoInfoText"

var player_in_range = false
var casinoTextIndex= 0
var casinoMessages = [
	"Ici, tu peux jouer les pièces que tu as collectées afin de...",
	"...DOUBLER TA MISE !",
	"(ou tout perdre...)",
	"La chance de doubler ta mise n'est pas très grande, mais chaque essai ne coûte qu'une seule pièce.",
	"Pour jouer, appuie sur la boîte !",
]

func _ready() -> void:
	casino_text.text = "Bienvenue au casino hivernal"

func _on_area_2d_body_entered(body: Node2D):
	print(body.name)
	if body.name == "Player":
		player_in_range = true
		print(player_in_range)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		
func _input(event):
	if player_in_range == true:
		if event.is_action_pressed("casino_interact"):
			casino_info_text.hide()
			if casinoTextIndex < casinoMessages.size():
				casino_text.text = casinoMessages[casinoTextIndex]
				casinoTextIndex += 1
