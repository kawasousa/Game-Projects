extends Area2D
class_name Asteroid

@onready var collision = $CollisionShape2D
var asteroidIndex: int
@export var speed: int = 0
@export var points: int = 0
@export var damage: int = 1;
const explosionScene = preload("res://scenes/entities/explosion.tscn")

func _physics_process(delta: float) -> void:
	translate(Vector2.LEFT * speed * Global.physicsSpeed * delta * Global.level.speed_factor);
	rotate(-0.01)

## Verifica se a nave bateu no asteroid
func _on_body_entered(body):
	if body is Player:
		body.takeDamage(damage)
		queue_free()

## Verifica se o tiro bateu no asteroid
func _on_area_entered(area):
	if area.is_in_group("PlayerProjectiles"):
		SoundManager.playSfx("explosion")
		area.queue_free()
		queue_free()
		
		createExplosion();
		Global.add_points(points);

func createExplosion():
	var explosion = explosionScene.instantiate()
	get_tree().get_current_scene().add_child(explosion);
	explosion.global_position = global_position
	Global.explosion_node.show_explosion_animation(global_position)

## Exclui o asteroid se ele sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
