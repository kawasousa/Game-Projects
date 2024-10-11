extends CanvasLayer


@onready var label = $Label
@onready var animation_player = $AnimationPlayer



func _ready():
	await animation_player.animation_finished
	showLabel()

func _input(event):
	if Input.is_action_just_pressed("advance"):
		animation_player.play("blink")
		await animation_player.animation_finished
		GameManager.fadeInScene("res://scenes/levels/StartLevel.tscn")

func showLabel() -> void:
	var visibleCharacters: int = label.get_visible_characters()
	if visibleCharacters < label.text.length():
		visibleCharacters += 1
		label.visible_characters = visibleCharacters
		
		await get_tree().create_timer(0.05).timeout
		showLabel()
