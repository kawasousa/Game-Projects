extends Node2D
class_name Level

signal newError;
signal graphHovered(minimumObstacles: int);

var time: int = 1;
var errors: int = 0;
@onready var timer: Timer = $Timer
@onready var board: Node2D = $Board
@export var graphs: Array[Graph] = [];
@export var title: String = "  Nível Normal  ";


func _ready() -> void:
	Game.emitLevelStarted(self);
	Sound.playMusic(MusicDB.SEA_THEME_1, true);
	
	for graph in graphs:
		graph.newError.connect(emitNewError);
		graph.hovered.connect(func(obstacles: int): graphHovered.emit(obstacles)); # propaga o sinal.
	
	timer.start();
	timer.timeout.connect(onTimerTimeout);

func reloadLevel():
	Game.changeSceneTo(Game.currentLevel);

#region Signals
func emitNewError():
	errors += 1;
	newError.emit();

func onTimerTimeout():
	time += 1;
#endregion
