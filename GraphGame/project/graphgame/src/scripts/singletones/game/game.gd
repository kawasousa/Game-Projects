extends Node
# Game global variables and functions

signal LevelStarted(level: Level);
signal LevelEnded;

@onready var levels: Array[String] = [SceneDB.TUTORIAL, SceneDB.LEVEL_1, SceneDB.LEVEL_2, SceneDB.TITLE_SCREEN];
var currentLevel: String;

func _ready() -> void:
	currentLevel = levels[0];
	set_process_mode(Node.PROCESS_MODE_ALWAYS);

func goToNextLevel():
	var level = levels.pop_front();
	changeSceneTo(level);
	currentLevel = level;

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
