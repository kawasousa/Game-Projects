extends CharacterBody2D

@onready var rayCast = $RayCast2D
@onready var sprite = $Sprite2D
@export var direction := Vector2.RIGHT
@export var speed = 10000


func _physics_process(delta):
	velocity = delta * speed * direction
	global_position.y += sin(Engine.get_frames_drawn() * 0.1) * 0.5
	sprite.rotation_degrees += sin(Engine.get_frames_drawn() * 0.1) * 0.8
	
	if rayCast.is_colliding():
		direction *= -1
		rayCast.rotation_degrees += 180
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body is Player:
		body.hurt()
