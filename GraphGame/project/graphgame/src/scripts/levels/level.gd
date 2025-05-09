extends Node2D
class_name Level

signal newError;
signal graphHovered(minimumObstacles: int);
signal levelCleared;

var time: int = 1;
var errors: int = 0;
@onready var timer: Timer = $Timer
@onready var board: Node2D = $Board
@export var graphs: Array[Graph] = [];
@export var title: String = "  Nível Normal  ";
@export var levelEndTrigger: LeveEndTrigger;

func _ready() -> void:
	Game.emitLevelStarted(self);
	Sound.playMusic(MusicDB.SEA_THEME_1, true);
	
	for graph in graphs:
		graph.newError.connect(emitNewError);
		graph.hovered.connect(func(obstacles: int): graphHovered.emit(obstacles)); # propaga o sinal.
		graph.graphCleaned.connect(removeGraph);
	
	Game.LevelOver.connect(reloadLevel);
	timer.start();
	timer.timeout.connect(onTimerTimeout);

func reloadLevel():
	Game.changeSceneTo(Game.currentLevel);

func removeGraph(graph: Graph):
	graphs.erase(graph);
	
	if graphs.is_empty():
		title = "  [wave]clice na placa![/wave]  "
		levelCleared.emit();

#region Signals
func emitNewError():
	errors += 1;
	newError.emit();

func onTimerTimeout():
	time += 1;
#endregion
