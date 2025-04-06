extends Area2D
class_name Projectile

@onready var sprite = $AnimatedSprite2D
const SPEED = 1000
var startPosition: Vector2;

func _ready() -> void:
	startPosition = global_position;

func _process(delta):
	global_position.y = startPosition.y
	translate(Vector2(SPEED, 0) * delta)
	sprite.play("shoot")

## Apaga a instância do tiro quando ele sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
