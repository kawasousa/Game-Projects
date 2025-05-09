extends Area2D
class_name LeveEndTrigger

signal clicked;


func _ready() -> void:
	body_entered.connect(onBodyEntered);
	area_entered.connect(onAreaEntered);

func emitClicked():
	clicked.emit();

func onAreaEntered(area: Area2D):
	if area is Mouse and not MouseHandler.click.is_connected(emitClicked):
			MouseHandler.click.connect(emitClicked);

func onAreaExited(area: Area2D):
	if area is Mouse and MouseHandler.click.is_connected(emitClicked):
		MouseHandler.click.disconnect(emitClicked);

func onBodyEntered(body: Node2D):
	if body is Player:
		Game.goToNextLevel();
