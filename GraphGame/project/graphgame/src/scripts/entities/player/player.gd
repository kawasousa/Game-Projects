extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $Sprite
@export var speed: int = 8000;
var direction: Vector2 = Vector2.ZERO;

func _process(delta: float) -> void:
	handleMovement(delta);
	handleSprite();
	move_and_slide();

func handleMovement(delta: float):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
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
