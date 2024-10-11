extends Node2D

@onready var camera = $Player/camera2d

func _ready():
	camera.limit_top = 0
	GameManager.fadeOutScene()
