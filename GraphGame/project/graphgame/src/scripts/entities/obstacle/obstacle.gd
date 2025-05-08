extends Area2D
class_name Obstacle

signal chosen(obs: Obstacle);
signal hovered;

@export var connections: Array[Obstacle] = [];
@export var ID: int = 1;
@onready var animation: AnimationPlayer = $Animation
@onready var mouseArea: Area2D = $MouseArea
var isChosen: bool;
var isMarked: bool;
var isHovered: bool;


func _ready() -> void:
	self.area_entered.connect(onAreaEntered);
	mouseArea.area_entered.connect(onMouseAreaEntered);
	mouseArea.area_exited.connect(onMouseAreaExited);
	MouseHandler.click.connect(onMouseClick);

func destroy():
	mouseArea.area_entered.disconnect(onMouseAreaEntered);
	mouseArea.area_exited.disconnect(onMouseAreaExited);
	animation.play_backwards("RESET");
	await animation.animation_finished;
	animation.play("die");
	await animation.animation_finished;
	queue_free();

func createConnectionsLine():
	for obstacle in connections:
		var line = Line2D.new();
		line.points = [self.global_position,obstacle.global_position];
		add_child(line);

func choose():
	isChosen = true;
	isMarked = true;
	for connection in connections:
		connection.isMarked = true;
	animation.play("floating");
	chosen.emit(self);

func unChoose():
	animation.play_backwards("up");
	await animation.animation_finished;
	animation.play("RESET");
	isChosen = false;
	isMarked = false;

#region Signals
func onAreaEntered(area: Area2D):
	if area is Obstacle and area.ID == ID:
		if not connections.has(area):
			connections.append(area);

func onMouseAreaEntered(area: Area2D):
	if area is Mouse and not isChosen:
		isHovered = true;
		animation.play("up");
		self.hovered.emit();

func onMouseAreaExited(area: Area2D):
	if area is Mouse and not isChosen:
		isHovered = false;
		animation.play_backwards("up");
		await animation.animation_finished;
		animation.play("RESET");

func onMouseClick():
	if isHovered and not isChosen:
		choose();
#endregion
