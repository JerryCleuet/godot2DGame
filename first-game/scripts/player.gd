extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $Jump

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var is_hurt = false
var is_dead = false
var hasASword = false

# Si le joueur prend un dégât
func _hurted():
	is_hurt = true
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Add the gravity.
	if not is_on_floor() && is_dead == false:
		velocity += get_gravity() * delta
		
	# Divide gravity by 2 if the player is dead	
	elif is_dead == true:
		velocity += get_gravity() * delta * 0.5
		
	if is_dead == false:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump.play()

		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if (is_hurt == true):
		animated_sprite.play("damage")
	
	if(is_hurt == false):
		# Play animations
		if is_on_floor():
			if hasASword:
				if (direction == 0):
					animated_sprite.play("idle_with_sword")
				# Si en train de courir
				else:
					animated_sprite.play("run_with_sword")
			# Si statique
			else:
				if (direction == 0):
					animated_sprite.play("idle")
				# Si en train de courir
				else:
					animated_sprite.play("run")
		# Si en train de sauter
		else:
			animated_sprite.play("jump")

		move_and_slide()
