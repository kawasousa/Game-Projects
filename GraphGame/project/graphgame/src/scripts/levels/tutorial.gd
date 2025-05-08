extends Level


func _ready() -> void:
	super();
	Sound.playMusic(MusicDB.NIGHT_THEME_1, true);
