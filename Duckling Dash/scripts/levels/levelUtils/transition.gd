extends CanvasLayer


func showContent() -> void:
	show()
	var animationPlayer: AnimationPlayer = $AnimationPlayer
	animationPlayer.play("showContent")
	await animationPlayer.animation_finished
	queue_free()

func hideContent(target) -> void:
	show()
	var animationPlayer = $AnimationPlayer
	animationPlayer.play("hideContent")
	await animationPlayer.animation_finished
	
	get_tree().call_deferred("change_scene_to_file", target)
