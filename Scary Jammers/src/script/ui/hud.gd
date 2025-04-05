extends CanvasLayer
class_name HUD

@onready var camera: Camera2D = $Camera;
@export var cameraTarget: CharacterBody2D;
@onready var lifeContainer: HBoxContainer = $MarginContainer/LifeContainer;

func _ready() -> void:
	await get_tree().process_frame;
	if Global.player:
		Global.player.lifeChange.connect(handleLifeContainer)

func _process(delta: float) -> void:
	if cameraTarget:
		camera.global_position = cameraTarget.global_position;

func handleLifeContainer(player: Player):
	for child in lifeContainer.get_children():
		child.queue_free();
	
	var lifeSprite := Sprite2D.new();
	lifeSprite.texture = load("res://src/resources/heartAtlasTexture.tres");
	
	lifeContainer.add_child(lifeSprite);
	for life in range(player.life):
		lifeSprite = lifeSprite
	print(player.life);
