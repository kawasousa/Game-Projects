class_name BasePowerUp
extends Area2D


func _ready() -> void:
	body_entered.connect(onBodyEntered)

func _physics_process(delta: float) -> void:
	rotate(delta*-4)
	global_position.x -= delta*100

func applyEffect(player: Player):
	pass

func onBodyEntered(body: CharacterBody2D):
	if body is Player:
		applyEffect(body);

func die():
	queue_free();
