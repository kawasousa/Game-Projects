extends CanvasLayer
class_name HUD

var level: Level;
@onready var titleLabel: RichTextLabel = $Title/TitleLabel
@onready var titleTexture: NinePatchRect = $Title/TitleTexture
@onready var title: Node2D = $Title
@onready var timeLabel: RichTextLabel = $Time/TimeLabel
@onready var errorLabel: RichTextLabel = $Errors/ErrorLabel
@onready var touchsLabel: RichTextLabel = $Touchs/TouchsLabel


func _ready() -> void:
	Game.LevelStarted.connect(setLevelStats);

func setLevelStats(gameLevel: Level):
	level = gameLevel;
	titleLabel.text = level.title;
	
	updateLevelTitle();
		
	level.timer.timeout.connect(updateLevelTime);
	level.newError.connect(updateLevelErrors);
	level.graphHovered.connect(updateTouchLabel);

func updateLevelErrors():
	errorLabel.text = str(level.errors);

func updateLevelTitle():
	titleTexture.size.x = titleLabel.get_total_character_count() * 16; #magic number porque sim. Não questiona.
	titleTexture.global_position.x = title.global_position.x - titleTexture.size.x/2;

	titleLabel.visible_characters = 0;
	get_tree().create_tween() \
		.tween_property(titleLabel, "visible_characters", titleLabel.get_total_character_count(), .5);

func updateLevelTime():
	timeLabel.text = str(level.time);
	timeLabel.scale = Vector2.ZERO;
	get_tree().create_tween().tween_property(timeLabel, "scale", Vector2.ONE, .1);

func updateTouchLabel(touchs: int):
	touchsLabel.text = str(touchs);
	touchsLabel.scale = Vector2.ZERO;
	get_tree().create_tween().tween_property(touchsLabel, "scale", Vector2.ONE, .1);
