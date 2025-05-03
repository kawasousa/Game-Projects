extends Area2D
class_name Mouse


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position();
