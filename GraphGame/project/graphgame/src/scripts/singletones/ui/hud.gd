extends CanvasLayer
class_name HUD

var level: Level;
@onready var titleLabel: RichTextLabel = $Title/TitleLabel
@onready var titleTexture: NinePatchRect = $Title/TitleTexture
@onready var title: Node2D = $Title


func _ready() -> void:
	Game.LevelStarted.connect(setLevelStats);

func setLevelStats(gameLevel: Level):
	level = gameLevel;
	titleLabel.text = level.title;
	
	titleTexture.size.x = titleLabel.get_total_character_count() * 18; #magic number porque sim. Não questiona.
	
	titleTexture.global_position.x = title.global_position.x - titleTexture.size.x/2;

	titleLabel.visible_characters = 0;
	get_tree().create_tween() \
		.tween_property(titleLabel, "visible_characters", titleLabel.get_total_character_count(), .5);
