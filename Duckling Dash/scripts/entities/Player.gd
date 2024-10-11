extends CharacterBody2D
class_name Player

@onready var animationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $sprite;
@onready var animationSprite = $AnimationSprite
@onready var marker_2d = $Marker2D
@onready var camera: Camera2D = $camera2d
var life: int = 1
var canMove: bool = true;
var speed: int = 3000;
var direction := Vector2.UP;
var rotatedDirection: Vector2
var ducklingPosition: Vector2
var spawnPosition: Vector2
var isCameraShaking: bool = false

func _ready():
	GameManager.player = self
	ducklingPosition = marker_2d.global_position
	spawnPosition = global_position
	if GameManager.PlayerDied:
		animationPlayer.play("rebornAnimation")
		GameManager.PlayerDied = false

func _physics_process(delta):
	ducklingPosition = marker_2d.global_position
	if canMove:
		movement(delta);
	handleSprite();
	
	if isCameraShaking:
		camera.offset = Vector2(randi_range(0,5), randi_range(0,5))

func movement(delta) -> void:
	rotatedDirection = direction.rotated(rotation);
	if Input.is_action_just_pressed("advance"):
		velocity = rotatedDirection * speed * delta * 20;
		animationSprite.play("run")
		SoundManager.playSfx("quack")
	else:
		velocity += rotatedDirection * -1 * speed * delta;
		velocity.y = min(velocity.y, 1000)
	move_and_slide();

func handleSprite() -> void:
	if velocity.y * rotatedDirection.y * -1 > speed / 4.0:
		sprite.play("down");
	else:
		sprite.play("up");

func hurt(damage = 1) -> void:
	life -= damage
	isCameraShaking = true
	await get_tree().create_timer(0.5).timeout
	isCameraShaking = false
	if life == 0:
		die()

func die() -> void:
	call_deferred("set_physics_process", false)
	animationPlayer.play("dieAnimation")
	await animationPlayer.animation_finished
	global_position = spawnPosition
	get_tree().call_deferred("reload_current_scene")
	GameManager.PlayerDied = true
