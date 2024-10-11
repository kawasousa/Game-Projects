extends CanvasLayer

@onready var resume_bttn = $VBoxContainer/VBoxContainer/resume_button
@onready var quit_bttn = $VBoxContainer/VBoxContainer/quit_button
@onready var restart_bttn = $VBoxContainer/VBoxContainer/restart_button

func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		resume_bttn.grab_focus()
		get_tree().paused = true
		visible = true

func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false
	

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/menu_inicial.tscn")


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
