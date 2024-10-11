extends Node2D

@onready var camera = $Player/camera2d


func _ready():
	camera.limit_left = -760
	SoundManager.playMusic("menuMusic")
