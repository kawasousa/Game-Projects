extends Area2D
class_name Mouse

signal click;


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		click.emit();
