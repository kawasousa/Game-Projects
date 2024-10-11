extends CharacterBody2D

@onready var sprite = $Sprite2D


func _on_area_2d_body_entered(body):
	if body is Player:
		sprite.global_position = body.ducklingPosition
		call_deferred("remove_child", sprite)
		body.call_deferred("add_child", sprite)
		queue_free()
