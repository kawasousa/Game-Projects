extends Area2D
class_name Obstacle

signal hovered(isHovered: bool);

var connections: Array[Obstacle];
@export var ID: int = 1;
var isChosen: bool = true;
@onready var animation: AnimationPlayer = $Animation


func _ready() -> void:
	self.area_entered.connect(onAreaEntered);
	self.area_exited.connect(onAreaExited);
	self.hovered.connect(onHovered);

func die():
	animation.play_backwards("RESET");
	await animation.animation_finished;
	animation.play("die");
	await animation.animation_finished;
	queue_free();

#region Signals

func onAreaEntered(area: Area2D):
	if area is Obstacle and area.ID == ID:
		if not connections.has(area):
			connections.append(area);
	elif area is Mouse:
		self.hovered.emit(true);

func onAreaExited(area: Area2D):
	if area is Mouse:
		self.hovered.emit(false);

func onHovered(isHovered: bool):
	if isHovered:
		animation.play("up");
		await animation.animation_finished;
		animation.play("floating");
		await animation.animation_finished;
	else:
		animation.play_backwards("up");
		await animation.animation_finished;
		animation.play("RESET");

#endregion
