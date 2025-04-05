extends Node


##################################### VARIABLES ####################################
var player: Player;

@onready var timer: Timer = $Timer
var game_over: bool = false
var game_win: bool = false

var max_game_days: int = 3
var game_day: int 
var game_seconds: int
var game_minutes: int
var game_match_minutes: int = 1

var invasion_rect_factor: float

var player_position: Vector2 = Vector2(385, 540)

var can_start_invasion_timer: bool = false
var can_spawn_enemies: bool = false
var can_spawn_shoot_resources: bool = true
##################################### SIGNALS ####################################
signal GameOver
##################################### FUNCTIONS ####################################
func _ready():
	reset_game_values()
	self.GameOver.connect(emitGameOver);

func _process(_delta):
	day_to_win()
	set_invasion_timer()

func set_invasion_timer() -> void:
	if can_start_invasion_timer and not game_over:
		invasion_rect_factor += 0.5
		if invasion_rect_factor >= 400:
			invasion_rect_factor = 0
			emitGameOver();
	else:
		invasion_rect_factor = 0

func reset_game_values() -> void:
	game_win = false
	game_over = false
	game_seconds = 0
	game_minutes = game_match_minutes
	timer.stop()
	player_position = Vector2(385, 540)
	invasion_rect_factor = 0
	can_start_invasion_timer = false
	can_spawn_enemies = false
	can_spawn_shoot_resources = true
	game_day = max_game_days

func _on_timer_timeout():
	if game_minutes == 0 and game_seconds == 0:
		game_day -= 1
		game_minutes = game_match_minutes
		game_seconds = 0
	if game_seconds == 0:
		game_seconds = 59
		game_minutes -= 1
	game_seconds -= 1

func day_to_win() -> void:
	if game_day == 0:
		game_win = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ToggleFullscreen"):
		if get_window().get_mode() == Window.MODE_FULLSCREEN:
			get_window().set_mode(Window.MODE_WINDOWED)
		else:
			get_window().set_mode(Window.MODE_FULLSCREEN)

func emitGameOver():
	GameOver.emit();
	player.emitPlayerDie();
