extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer;
var musicQueue: Array[String] = [];

var sfx: Dictionary = {
	"quack": {
		"path": "res://assets/sounds/sfx/Duck Quack Sfx.mp3",
		"volume": -30
	}
};

var musics: Dictionary = {
	"menuMusic": {
		"path": "res://assets/sounds/music/Ben Bostick - Strange Duck - Instrumental Version.mp3",
		"volume": -20
	},
	"menuMusic2": {
		"path": "res://assets/sounds/music/Buck Dance in past Tense - Prophecy Playground.mp3",
		"volume": -20
	}
};



##Play the sound effect based on conveyed sfx dictionary key
func playSfx(soundName: String) -> void:
	var soundVolume: float = sfx[soundName]["volume"];
	var soundPath: String = sfx[soundName]["path"];
	var sound = ResourceLoader.load(soundPath);
	
	var sfxPlayer := AudioStreamPlayer.new()
	get_tree().get_current_scene().add_child(sfxPlayer)
	sfxPlayer.set_stream(sound);
	sfxPlayer.set_volume_db(soundVolume);
	sfxPlayer.play();
	
	await sfxPlayer.finished
	sfxPlayer.queue_free()

func playMusic(musicName: String, playNow: bool = false) -> void:
	var musicVolume: float = musics[musicName]["volume"];
	var musicPath: String = musics[musicName]["path"];
	var music = ResourceLoader.load(musicPath);
	musicPlayer.set_volume_db(musicVolume);
	
	if playNow:
		var tween = get_tree().create_tween()
		tween.tween_property(musicPlayer, "volume_db", -50, 1)
		
		musicPlayer.set_stream(music);
		musicPlayer.play();
		tween.tween_property(musicPlayer, "volume_db", musicVolume, 1)
	else:
		if musicPlayer.playing == false:
			musicPlayer.set_stream(music);
			musicPlayer.play();

func addMusicToQueue(musicName: String) -> void:
	musicQueue.append(musicName)

func removeMusicFromQueue(musicName: String) -> void:
	musicQueue.erase(musicName)

func _on_music_player_finished():
	if musicQueue.size() > 0:
		var music = musicQueue.pop_front()
		playMusic(music)
