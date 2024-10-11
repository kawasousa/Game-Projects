extends Control

@onready var start_button = $VBoxContainer/ButtonsContainer/CenterContainer/start_button
@onready var flysh_sprite = $size_tests/flysh

func _ready():
	start_button.grab_focus()

func _process(_delta):
	change_button_indicator()

func change_button_indicator():
	if start_button.has_focus():
		flysh_sprite.position.y = 295
	else:
		flysh_sprite.position.y = 340

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/nivel_1.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
