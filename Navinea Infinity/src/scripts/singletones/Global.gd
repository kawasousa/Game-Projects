extends Node

signal gameOver;
signal tutorialFinished

var physicsSpeed: float = 1.0;
@onready var transition: CanvasLayer = $Transition
var canShowTutorial: bool = true;

var level: Level
var player: Player
var explosion_node = null

var currentScore: int = 0
var highScore: int = 0
var highScoreUsername: String

var scene: Dictionary = {
	"startMenu": "res://src/scenes/ui/start_menu.tscn",
	"gameOverMenu": "res://src/scenes/ui/game_over_menu.tscn",
	"level": "res://src/scenes/levels/level.tscn"
}


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	update_highScore()

func add_points(points: int) -> void:
	currentScore += points

func update_highScore() -> void:
	highScore = max(highScore, currentScore)

func restart_game_values() -> void:
	currentScore = 0

func isNewHighScore() -> bool:
	return currentScore >= highScore;

func emitGameOver():
	gameOver.emit();

func pauseScene():
	get_tree().paused = true;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and get_tree().paused:
		get_tree().paused = false

func showTutorial():
	DialogueManager.show_dialogue_balloon(load("res://src/scripts/addons/dialogues/tutorial.dialogue"), "tutorial");
	await DialogueManager.dialogue_ended
	canShowTutorial = false;
	tutorialFinished.emit();

func setPhysicSpeed(speed: float):
	physicsSpeed = speed;

func changeScene(path: String):
	var animation: AnimationPlayer = transition.get_node("Animation");
	animation.play("fadein")
	await animation.animation_finished;
	get_tree().change_scene_to_file(path);
	animation.play("fadeout")
