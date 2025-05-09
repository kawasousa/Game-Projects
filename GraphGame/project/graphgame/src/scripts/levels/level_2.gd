extends Level


func _ready() -> void:
	super();
	Sound.playMusic(MusicDB.FIELD_THEME_1, true);
