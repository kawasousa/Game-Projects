extends Area2D
class_name LeveEndTrigger


func onBodyEntered(body: PhysicsBody2D):
	if body is Player:
		print("player finalizou a fase")
