class_name LifeIncrasePowerUp
extends BasePowerUp

@export var incraseAmount: int = 1;
@onready var notifier: VisibleOnScreenNotifier2D = $Notifier;


func _ready() -> void:
	super();
	notifier.screen_exited.connect(queue_free);

func applyEffect(player: Player):
	player.incraseLife(incraseAmount);
	die();
