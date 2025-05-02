extends Control

@onready var startButton: Button = $start

func _ready() -> void:
	startButton.grab_focus()
	startButton.pressed.connect(onStartPressed);
	
	Global.restart_game_values()
	SoundManager.playMusic("menu")
	SoundManager.removeMusicFromQueue("menu2")

## Muda a cena para o level
func onStartPressed() -> void:
	Global.changeScene(Global.scene["level"])
