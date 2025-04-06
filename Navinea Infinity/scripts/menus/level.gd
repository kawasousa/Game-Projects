extends Node2D
class_name Level

@onready var background_material: ShaderMaterial = $background.material;
@onready var asteroids_group: Node2D = $asteroids_group
@onready var top_spawn_marker: Marker2D = $SpawnMarkers/TopSpawnMarker
@onready var bottom_spawn_marker: Marker2D = $SpawnMarkers/BottomSpawnMarker

var asteroids: Array[PackedScene] = [
	preload("res://scenes/entities/big_asteroid.tscn"),
	preload("res://scenes/entities/little_asteroid.tscn")
]
var speed_factor : float = 1
var can_spawn_enemies: bool = true

func _ready() -> void:
	Global.level = self
	Global.gameOver.connect(onGameOver);
	Global.restart_game_values()

func _process(_delta) -> void:
	move_backgroung()

## Controla o nascimento dos asteróides em uma posição aleatória
func _on_asteroid_spawn_timer_timeout() -> void:
	if can_spawn_enemies:
		spawnAsteroid();

func spawnAsteroid() -> void:
		var asteroid = asteroids.pick_random().instantiate();
		var spawnX = randi_range(bottom_spawn_marker.global_position.x, top_spawn_marker.global_position.x);
		var spawnY = randi_range(bottom_spawn_marker.global_position.y, top_spawn_marker.global_position.y);
		asteroid.global_position = Vector2(spawnX, spawnY);
		asteroids_group.add_child(asteroid)

## Timer que controla a velocidade dos asteroids criados
func _on_increase_ast_speed_timer_timeout() -> void:
	if can_spawn_enemies:
		speed_factor += 0.1
		speed_factor = min(speed_factor, 5)

func onGameOver():
	var gameOverMenu = load(Global.scene["gameOverMenu"]).instantiate();
	add_child(gameOverMenu);
	if Global.gameOver.is_connected(onGameOver):
		Global.gameOver.disconnect(onGameOver)
	can_spawn_enemies = false

## Move o fundo
func move_backgroung() -> void:
	background_material.set_shader_parameter("displacement", (Global.player.global_position.y - 432) * 0.0001)
