extends Area2D
class_name LeveEndTrigger


func _ready() -> void:
	body_entered.connect(onBodyEntered);

func onBodyEntered(body: Node2D):
	if body is Player:
		Game.goToNextLevel();
