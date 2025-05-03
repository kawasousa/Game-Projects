extends CanvasLayer

signal finished;

@onready var animation: AnimationPlayer = $Animation


func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS);
	animation.play("RESET");

func fadeIn():
	animation.play("fade");
	await animation.animation_finished;
	self.finished.emit();

func fadeOut():
	animation.play_backwards("fade");
	await animation.animation_finished;
	self.finished.emit();
