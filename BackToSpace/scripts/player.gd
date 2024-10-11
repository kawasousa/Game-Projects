extends CharacterBody2D

@onready var sprite = $Sprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var fuel_capacity = 50
var current_fuel = fuel_capacity
const FLY_VELOCITY = -100
const SPEED = 150.0
const JUMP_VELOCITY = -275.0


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	fly()
	jump()
	movement(delta)


func jump():
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
 
func fly():
	if Input.is_action_pressed("ui_up") and current_fuel > 0:
		velocity.y = FLY_VELOCITY
		current_fuel -= 1
		print(current_fuel)

func movement(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed('ui_left') or Input.is_action_pressed('ui_right'):
		velocity.x = SPEED * direction * delta * 80
	else:
		velocity.x = 0

	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	move_and_slide()
