extends Node2D
class_name Level

var time: int = 0;
@onready var timer: Timer = $Timer
@onready var board: Node2D = $Board
var graphs: Array[Graph] = [];
@export var title: String = "Nível BlaBlaBlaBlaBla";


func _ready() -> void:
	Game.emitLevelStarted(self);
	Sound.playMusic(MusicDB.NIGHT_THEME_1, true);
	
	timer.start();
	timer.timeout.connect(onTimerTimeout);

func collectObstacles():
	pass

func onTimerTimeout():
	time += 1;


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		Game.changeSceneTo("res://src/scenes/levels/tutorial/Tutorial.tscn");
