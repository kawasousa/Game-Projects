extends Area2D

@onready var show_area_animation = $".."
func _on_body_entered(body):
	if body.name == "Player":
		show_area_animation.play("show_area")


func _on_body_exited(body):
	if body.name == "Player":
		show_area_animation.play("hide_area")
