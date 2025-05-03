extends Node
# Game global variables and functions

signal LevelStarted(level: Level);


func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS);

func changeSceneTo(scene: String):
	Transition.fadeIn();
	get_tree().set_pause(true);
	await Transition.finished;
	get_tree().change_scene_to_file(scene);
	await LevelStarted;
	Transition.fadeOut();
	await Transition.finished;
	get_tree().set_pause(false);

func emitLevelStarted(level: Level):
	self.LevelStarted.emit(level);
