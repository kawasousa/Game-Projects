extends CanvasLayer

@onready var animation: AnimationPlayer = $Animation
@onready var restartButton: Button = $VBoxContainer/RestartButton
@onready var quitButton: Button = $VBoxContainer/QuitButton;
@onready var setUsernameLabel: RichTextLabel = $NewHighScore/setUsernameLabel;
@onready var highscoreLabel: RichTextLabel = $highScore;
@onready var usernameLineEdit: LineEdit = $NewHighScore/Username;
var scoreDraw: int = 0;
@export var startMenuScene: PackedScene;


func _ready():
	restartButton.pressed.connect(onRestartButtonPressed);
	quitButton.pressed.connect(onQuitButtonPressed);
	usernameLineEdit.text_submitted.connect(onUsernameTextSubmitted);

	Global.setPhysicSpeed(0.05);

	setHighScoreLabel();
	setButtonFocus();
	
	animation.play("show");
	await animation.animation_finished;
	animation.play("floating");
	
	SoundManager.addMusicToQueue("menu2");

func setHighScoreLabel():
	if Global.isNewHighScore():
		while scoreDraw < Global.highScore:
			highscoreLabel.text = "novo recorde: " + str(scoreDraw);
			scoreDraw = move_toward(scoreDraw, Global.highScore, 10);
			await get_tree().create_timer(0.005).timeout
		highscoreLabel.text =\
			"[wave amp=50.0 freq=5.0 connected=1]novo recorde: {0}[/wave]"\
			.format([scoreDraw])
	else:
		highscoreLabel.text = "recorde: " + str(Global.highScore);
		usernameLineEdit.text = "por " + Global.highScoreUsername;

func setButtonFocus():
	if Global.isNewHighScore():
		usernameLineEdit.grab_focus();
		setUsernameLabel.show();
	else:
		restartButton.grab_focus();
		setUsernameLabel.hide();

func onUsernameTextSubmitted(username: String):
	Global.highScoreUsername = username;
	restartButton.grab_focus();
	setUsernameLabel.hide();

## Se o botão de tentar novamente for clicado, a cena é reiniciada.
func onRestartButtonPressed():
	Global.changeScene(Global.scene["level"]);
	Global.setPhysicSpeed(1);

## Se o botão de sair for pressionado, a cena muda para o menu inicial
func onQuitButtonPressed():
	Global.changeScene(Global.scene["startMenu"])
	Global.setPhysicSpeed(1);
