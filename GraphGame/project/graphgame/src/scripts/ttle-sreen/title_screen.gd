extends Control

@onready var start: Button = $ButtonContainer/Start
@onready var exit: Button = $ButtonContainer/Exit


func _ready() -> void:
	start.pressed.connect(onStartPressed);
	exit.pressed.connect(onExitPressed);
	start.grab_focus();
	Transition.fadeOut();
	await Transition.finished;
	Sound.playMusic(MusicDB.TRACK_4)

func onStartPressed() -> void:
	Game.goToNextLevel();

func onExitPressed() -> void:
	Transition.fadeIn();
	await Transition.finished;
	get_tree().quit()
