extends Node2D
class_name Graph

signal newError;
signal hovered(minimumObstacles: int);

@export var obstacles: Array[Obstacle];
@export var minimumVertices: int = 0;
var chosenObstacles: Array[Obstacle];

func _ready() -> void:
	for obstacle in obstacles:
		obstacle.chosen.connect(onObstacleChosen);
		obstacle.hovered.connect(func(): hovered.emit(minimumVertices));

func destroyObstacles():
	for obstacle in obstacles:
		obstacle.destroy();
	chosenObstacles.clear();
	obstacles.clear();

func resetObstacles():
	for obstacle in obstacles:
		obstacle.unChoose();
	chosenObstacles.clear();
	newError.emit();

#region Signals
func onObstacleChosen(obstacle: Obstacle):
	chosenObstacles.append(obstacle);
	if chosenObstacles.size() == minimumVertices:
		for vertice in obstacles:
			if not vertice.isMarked:
				resetObstacles();
				return;
		destroyObstacles();
#endregion
