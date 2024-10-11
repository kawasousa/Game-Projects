extends Area2D

@export_file() var targetScene: String
@export var startMonitoring: bool = false


func _ready():
	set_monitoring(startMonitoring)

func _on_body_entered(body):
	if body is Player:
		GameManager.fadeInScene(targetScene)
		call_deferred("set_monitoring", false)
