extends Node2D


@onready var animationPlayer = $AnimationPlayer
@onready var transition = $Transition
@onready var transitionPlayer = $Transition/AnimationPlayer
@onready var name_label = $nameLabel


func _ready():
	transition.showContent()
	await transitionPlayer.animation_finished
	animationPlayer.play("finalCutscene")
	await animationPlayer.animation_finished
	showLabel(name_label)
	animationPlayer.play("showLogo")
	await animationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/levelUtils/GameCover.tscn")

func showLabel(Textlabel) -> void:
	var visibleCharacters: int = Textlabel.get_visible_characters()
	if visibleCharacters < Textlabel.text.length():
		visibleCharacters += 1
		Textlabel.visible_characters = visibleCharacters
		
		await get_tree().create_timer(0.05).timeout
		showLabel(Textlabel)
