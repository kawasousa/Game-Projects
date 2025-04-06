extends CharacterBody2D
class_name Player

@onready var camera = $Camera2D
@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@export var projectil: PackedScene;

var _canMove = true;
var _canShoot = true;
var _isCameraShaking: bool = false;
var direction: Vector2 = Vector2.ZERO;

const SPEED = 30000;
const RECOIL = -4000;
@export var maxShoot = 2;
var maxLife: int = 4;
var lifePoints: int = maxLife;


func _ready():
	Global.player = self

func _process(_delta):
	handledAnimation()
	if _isCameraShaking:
		camera.offset = Vector2(randi_range(0, 6), randi_range(0, 6))

func _physics_process(delta):
	global_position = global_position.clamp(Vector2(40,40), Vector2(920,824));
	
	handleMovement(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _canShoot:
		attack();

## Atirar
func attack():
	if get_tree().get_nodes_in_group("PlayerProjectiles").size() < maxShoot:
		var projectile_instance: Projectile = projectil.instantiate()
		projectile_instance.global_position = Vector2(global_position.x + 56, global_position.y)
		get_tree().get_current_scene().add_child(projectile_instance)
		projectile_instance.add_to_group("PlayerProjectiles")
		
		SoundManager.playSfx("shoot")

## Movemento da nave
func handleMovement(delta):
	if _canMove:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
		velocity = direction * SPEED * delta * Global.physicsSpeed;
		if direction.x == 0:
			velocity.x = RECOIL * delta
	
	if lifePoints == 0:
		rotate(0.005)
		velocity = Vector2.RIGHT * RECOIL*delta
		animated_sprite_2d.play("idle")
	
	move_and_slide()

func handledAnimation() -> void:
	match direction.y:
		-1.0:
			sprite.play("going_up")
		0.0:
			sprite.play("idle")
		1.0:
			sprite.play("going_down")

func takeDamage(damage: int) -> void:
	lifePoints -= damage;
	SoundManager.playSfx("damage");
	animation_player.play("damage_animation");
	
	_isCameraShaking = true
	await get_tree().create_timer(0.5).timeout
	_isCameraShaking = false
	
	handleLifePoints();

func handleLifePoints() -> void:
	lifePoints = max(lifePoints, 0)
	if lifePoints == 0:
		die()

func die() -> void:
	collision.set_disabled(true);
	_canMove = false
	_canShoot = false

	Global.emitGameOver()
