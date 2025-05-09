extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var navAgent: NavigationAgent2D = $NavAgent
@export var speed: int = 8000;
@export var levelEndTrigger: LeveEndTrigger;
var direction: Vector2 = Vector2.ZERO;


func _ready() -> void:
	if levelEndTrigger: levelEndTrigger.clicked.connect(setTargetPosition);

func _physics_process(delta: float) -> void:
	handleMovement(delta);
	handleSprite();
	move_and_slide();

func die():
	set_physics_process(false);
	sprite.play("die");
	await sprite.animation_finished;
	Game.LevelOver.emit();

func handleMovement(delta: float):
	direction = to_local(navAgent.get_next_path_position()).normalized();
	velocity = direction * speed * delta;

func handleSprite():	
	match direction:
		Vector2.ZERO:
			sprite.play("idle");
		Vector2.LEFT:
			sprite.play("run");
			sprite.set_flip_h(true);
		Vector2.RIGHT:
			sprite.play("run");
			sprite.set_flip_h(false);
		_:
			sprite.play("run");

func setTargetPosition():
	if levelEndTrigger:
		navAgent.target_position = levelEndTrigger.global_position;
