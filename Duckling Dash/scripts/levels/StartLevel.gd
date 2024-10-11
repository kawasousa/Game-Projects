extends Node2D
class_name Level

@onready var animationPlayer = $AnimationPlayer
@onready var player = $Player
@onready var camera = $Player/camera2d
@onready var tutorialLabel = $TutorialLabel
@onready var duck = $Duck
@onready var transition = $Transition


func _ready():
	transition.showContent()
	player.hide()
	player.canMove = false
	animationPlayer.play("cameraAnimation")
	await animationPlayer.animation_finished
	animationPlayer.play("firstCutscene")
	SoundManager.playMusic("menuMusic2")
	camera.limit_top = 0
	tutorialLabel.set_visible_characters(0)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "firstCutscene":
		player.show()
		player.canMove = true
		await get_tree().create_timer(1).timeout
		showLabel(tutorialLabel)

func showLabel(Textlabel) -> void:
	var visibleCharacters: int = Textlabel.get_visible_characters()
	if visibleCharacters < Textlabel.text.length():
		visibleCharacters += 1
		Textlabel.visible_characters = visibleCharacters
		
		await get_tree().create_timer(0.05).timeout
		showLabel(Textlabel)
