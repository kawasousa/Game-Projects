extends Node

var player: Player
var PlayerDied: bool = false

func fadeInScene(target) -> void:
	var TRANSITION = preload("res://scenes/levels/levelUtils/Transition.tscn")
	var transition = TRANSITION.instantiate()
	get_tree().get_current_scene().call_deferred("add_child", transition)
	transition.hideContent(target)

func fadeOutScene() -> void:
	var TRANSITION = preload("res://scenes/levels/levelUtils/Transition.tscn")
	var transition = TRANSITION.instantiate()
	get_tree().get_current_scene().add_child(transition)
	transition.showContent()
