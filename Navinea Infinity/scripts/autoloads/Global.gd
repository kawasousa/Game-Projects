extends Node

signal gameOver

@onready var transition: CanvasLayer = $Transition
var physicsSpeed: float = 1.0;

var level: Level
var player: Player
var explosion_node = null

var currentScore: int = 0
var highScore: int = 0
var highScoreUsername: String
var new_highScore: bool = false

var scene: Dictionary = {
	"startMenu": "res://scenes/ui/start_menu.tscn",
	"gameOverMenu": "res://scenes/ui/game_over_menu.tscn",
	"level": "res://scenes/levels/level.tscn"
}


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	update_highScore()
	set_new_highScore()

func add_points(points: int) -> void:
	currentScore += points

func update_highScore() -> void:
	highScore = max(highScore, currentScore)

func restart_game_values() -> void:
	currentScore = 0
	new_highScore = false

func set_new_highScore() -> void:
	if currentScore >= highScore:
		new_highScore = true

func isNewHighScore() -> bool:
	return currentScore >= highScore;

func emitGameOver():
	gameOver.emit();

func setPhysicSpeed(modifier: float):
	physicsSpeed = modifier;

func changeScene(path: String):
	var animation: AnimationPlayer = transition.get_node("Animation");
	animation.play("fadein")
	await animation.animation_finished;
	get_tree().change_scene_to_file(path);
	animation.play("fadeout")
