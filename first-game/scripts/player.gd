extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $Jump

var SPEED := 130.0
var JUMP_VELOCITY := -300.0

var hasASword := false
var power_up := false

enum State { NORMAL, HURT, MURASAKI, DEAD }
var state := State.NORMAL


func _ready():
	position = SaveManager.spawn_position
	hasASword = SaveManager.hasASword
	power_up = SaveManager.power_up
# -------------------------
# PHYSICS
# -------------------------
func _physics_process(delta: float) -> void:

	if state == State.MURASAKI:
		move_and_slide()
		return
	# buffs
	if power_up:
		SPEED = 400
		JUMP_VELOCITY = -700

	var direction := Input.get_axis("ui_left", "ui_right")

	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()
		
	if Input.is_action_just_pressed("Murasaki"):
		if power_up:
			_trigger_murasaki()
	# movement
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# animations only if not hurt
	if state == State.NORMAL:
		_update_animation(direction)

	move_and_slide()


# -------------------------
# ANIMATIONS
# -------------------------
func _update_animation(direction: float) -> void:

	if not is_on_floor():
		if power_up:
			animated_sprite.play("jump_with_powerup")
		else:
			animated_sprite.play("jump")
		return

	if power_up:
		if direction == 0:
			animated_sprite.play("idle_with_powerup")
		else:
			animated_sprite.play("run_with_powerup")

	elif hasASword:
		if direction == 0:
			animated_sprite.play("idle_with_sword")
		else:
			animated_sprite.play("run_with_sword")

	else:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")


# -------------------------
# COMBAT ENTRY POINT
# -------------------------
func on_slime_hit(slime):

	if state != State.NORMAL:
		return

	if slime == null:
		return

	# GIANT SLIME (flag via group)
	if slime.is_in_group("giant_slimes"):
		_handle_giant_slime(slime)
		return

	_handle_normal_slime(slime)


# -------------------------
# NORMAL SLIME RULES
# -------------------------
func _handle_normal_slime(slime):

	# power_up → Murasaki
	if power_up:
		slime.die()
		return

	# sword → kill instant
	if hasASword:
		slime.die()
		return

	# sinon mort joueur
	hurt()


# -------------------------
# GIANT SLIME RULES
# -------------------------
func _handle_giant_slime(slime):

	# SEULE condition pour tuer → power_up
	if power_up:
		_murasaki_kill(slime)
		SaveManager.coins += 10
		return

	# sinon → mort joueur (même avec sword)
	hurt()


# -------------------------
# DAMAGE
# -------------------------
func hurt():

	if state != State.NORMAL:
		return

	state = State.DEAD

	animated_sprite.play("damage")

	await get_tree().create_timer(0.4).timeout

	_respawn()
		
func _respawn():

	global_position = SaveManager.spawn_position
	velocity = Vector2.ZERO
	state = State.NORMAL

func _murasaki_kill(slime):

	if state != State.NORMAL:
		return

	state = State.HURT  # bloque mouvement

	velocity = Vector2.ZERO

	animated_sprite.play("Murasaki")

	await animated_sprite.animation_finished

	if slime != null:
		slime.die()

	state = State.NORMAL
	
func _trigger_murasaki():

	if state != State.NORMAL:
		return

	state = State.MURASAKI

	velocity = Vector2.ZERO
	animated_sprite.play("Murasaki")

	await animated_sprite.animation_finished

	state = State.NORMAL
