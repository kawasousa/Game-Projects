extends Area2D
class_name LeveEndTrigger


func onBodyEntered(body: Node2D):
	print("um  node bateu")
	if body is Player:
		print("player finalizou a fase")
