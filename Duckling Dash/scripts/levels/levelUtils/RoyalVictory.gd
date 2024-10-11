extends Area2D

@export var canChangeMonitoring = true

func _on_body_entered(body):
	if body is Player:
		body.rotation_degrees = rotation_degrees
		body.velocity = Vector2.ZERO
		body.global_position = global_position
		if canChangeMonitoring:
			call_deferred("set_monitoring", false)
