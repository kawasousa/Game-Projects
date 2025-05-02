extends CanvasLayer

@onready var hit_points_label: RichTextLabel = $hitPoints;
@onready var score_label: Label = $score;
var score_draw: int = 0


func _process(_delta):
	update_hp_label()
	update_score_label()

func update_hp_label() -> void:
	var text = "vida: " + "<".repeat(max(0,Global.player.lifePoints));
	hit_points_label.text = text

func update_score_label() -> void:
	var increase_speed = max((Global.currentScore - score_draw) / 20, 5)
	score_draw = move_toward(score_draw, Global.currentScore, increase_speed)
	score_label.text = "score:" + str(score_draw)
