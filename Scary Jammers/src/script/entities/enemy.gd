extends BaseEntity
class_name Enemy

var speed = 8000
@onready var sprite := $Sprite
@onready var collision := $Collision
@onready var attackArea: Area2D = $AttackArea
@onready var monitoringArea: Area2D = $MonitoringArea


func _ready() -> void:
	self.monitoringArea.body_entered.connect(onMonitoringAreaBodyEnter);
	#attackArea.set_monitoring(false);

func _physics_process(delta):
	if canMove: movement(delta);
	else: velocity = Vector2.ZERO;
	move_and_slide()

func movement(delta) -> void:
	if Global.player:
		var direction = position.direction_to(Global.player.global_position);
		#velocity = direction * delta * speed;
		sprite.flip_h = direction.x < 0
	
	if velocity == Vector2.ZERO:
		sprite.play("idle");
	else: sprite.play("run");

func takeDamage(damage: int):
	super(damage);
	sprite.play("hurt");
	await sprite.animation_finished;

func die():
	super();
	sprite.play("die");

func onMonitoringAreaBodyEnter(body: Node2D):
	if body is Player:
		canMove = false;
		sprite.play("attack");
		attackArea.set_monitoring(true);
		await sprite.animation_finished;
		attackArea.set_monitoring(false);
		canMove = true;

func onAttackAreaBodyEntered(body: Node2D):
	if body is Player:
		attack(body);
