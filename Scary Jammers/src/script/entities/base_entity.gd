extends CharacterBody2D
class_name BaseEntity

@export var life: int = 2;
@export var damage: int = 2;
var canMove = true

func attack(entity: BaseEntity) -> void:
	entity.takeDamage(damage);

func takeDamage(damage: int) -> void:
	life -= damage;
	if life <= 0: die();

func die():
	canMove = false;
