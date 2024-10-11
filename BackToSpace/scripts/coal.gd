extends Area2D

@onready var game_manager = $"../../Game_Manager"
@onready var player = $"../../Player"


func _on_body_entered(body):
	if body == player:
		game_manager.add_coal()
		print("encostou no carvão")
