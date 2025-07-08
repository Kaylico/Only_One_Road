extends CharacterBody2D

@export var speed: float         = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float       = 900.0
@export var fall_limit: float    = 1000.0

@onready var anim: AnimatedSprite2D = $Anim

func _physics_process(delta: float) -> void:
	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * speed

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	if dir == 0.0:
		anim.play("idle")
	else:
		anim.flip_h = dir < 0.0
		anim.play("run")

	move_and_slide()

	if global_position.y > fall_limit:
		_respawn()

func _respawn() -> void:
	velocity = Vector2.ZERO
	get_tree().reload_current_scene()
