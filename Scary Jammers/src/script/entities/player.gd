extends BaseEntity
class_name Player

signal lifeChange(player: Player);
signal playerDie;

@export var speed = 20000
@export var maxLife: int = 5;
@onready var attackArea: Area2D = $AttackArea
@onready var sprite = $Sprite
var projectile: Projectile;
var lastDirection: Vector2;

func _ready():
	Global.player = self;
	life = maxLife;
	attackArea.body_entered.connect(onAttackAreaEntered)

func _physics_process(delta):
	if canMove: handleMovement(delta);
	else: velocity = Vector2.ZERO;
	
	move_and_slide()

func handleMovement(delta) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	
	if direction.x != 0:
		sprite.flip_h = direction.x < 0;
		lastDirection = direction;
	
	velocity = direction * delta * speed;
	
	if direction == Vector2.ZERO:
		sprite.play("idle");
	else: sprite.play("walking")

func takeDamage(damage: int) -> void:
	print("player atacado")
	sprite.play("hurt");
	await sprite.animation_finished;
	super(damage);

func die():
	sprite.play("death")
	await sprite.animation_finished
	emitPlayerDie();

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		sprite.play("attack")
		canMove = false
		attackArea.set_monitoring(true);
		await sprite.animation_finished
		canMove = true
		attackArea.set_monitoring(false);

func onAttackAreaEntered(body: Node2D):
	if body is Enemy:
		attack(body);
		print("player atacou " + body.name);

func emitPlayerDie():
	playerDie.emit();

func emitLifeChange():
	lifeChange.emit(self);
