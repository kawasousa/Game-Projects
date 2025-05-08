extends Node
# Game sound manager

@onready var player: AudioStreamPlayer = $Player
var queue: Array[String] = [];
var lastMusic: String;

func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS);
	player.finished.connect(_onPlayerFinished);

## Toca o efeito sonoro independente se algum outro já estiver tocando.
func playSFX(sfxName: String):
	var sfxPlayer := AudioStreamPlayer.new();
	var sfx = ResourceLoader.load(sfxName);
	
	
	add_child(sfxPlayer);
	sfxPlayer.set_stream(sfx);
	sfxPlayer.play();
	
	await sfxPlayer.finished;
	sfxPlayer.queue_free();

## Se playNow, inicia a música. Se não, adiciona na fila.
func playMusic(musicName: String, playNow := false):
	var music = ResourceLoader.load(musicName);
	lastMusic = musicName;
	
	get_tree().create_tween().tween_property(player, "volume_db", -80, 1);
	if playNow:
		player.set_stream(music);
		player.play();
		
	elif not player.playing:
		player.set_stream(music);
		player.play();
	else:
		addToQueue(musicName);
	get_tree().create_tween().tween_property(player, "volume_db", 24, 1);

func addToQueue(musicName: String):
	queue.append(musicName);

func removeFromQueue(musicName: String):
	if queue.has(musicName):
		queue.erase(musicName);

func CleanQueue():
	queue.clear();

func _onPlayerFinished():
	if queue.size() > 0:
		var musicName = queue.pop_front();
		playMusic(musicName)
	else:
		playMusic(lastMusic);
