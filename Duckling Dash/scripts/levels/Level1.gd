extends Node2D

@onready var royalVictory = $RoyalVictories/RoyalVictory
@onready var royalVictory_1 = $RoyalVictories/RoyalVictory1
@onready var royalVictory_2 = $RoyalVictories/RoyalVictory2
@onready var royalVictory_4 = $RoyalVictories/RoyalVictory4
@onready var royalVictory_5 = $RoyalVictories/RoyalVictory5
@onready var royal_victory_6 = $RoyalVictories/RoyalVictory6
@onready var label = $Label
@onready var label_2 = $Label2
@onready var camera = $Player/camera2d
@onready var canvasModulate = $CanvasModulate
@onready var staticBody = $StaticBody2D2
@export var changeRotation = 90


func _ready():
	SoundManager.playMusic("menuMusic", true)
	GameManager.fadeOutScene()
	camera.limit_bottom = 1920
	camera.limit_top = -3264
	setModulate()
	showLabel(label)

func showLabel(Textlabel) -> void:
	var visibleCharacters: int = Textlabel.get_visible_characters()
	if visibleCharacters < Textlabel.text.length():
		visibleCharacters += 1
		Textlabel.visible_characters = visibleCharacters
		
		await get_tree().create_timer(0.05).timeout
		showLabel(Textlabel)
	
func _on_waterfall_body_exited(body):
	if body is Player:
		body.call_deferred("set_physics_process", false)
		body.velocity = Vector2.ZERO
		var tween = get_tree().create_tween()
		tween.tween_property(body, "global_position", royalVictory_4.global_position, 0.5)
		royalVictory_4.call_deferred("set_monitoring", true)
		await tween.finished
		body.call_deferred("set_physics_process", true)

func setModulate() -> void:
	var date = Time.get_datetime_dict_from_system()
	var hour = date["hour"]
	canvasModulate.set_visible(hour > 18)

func _on_timer_timeout():
	if royalVictory_5.rotation_degrees == 90:
		royalVictory_5.rotation_degrees = 180
	else:
		royalVictory_5.rotation_degrees = 90
	
	if royalVictory.rotation_degrees == 0:
		royalVictory.rotation_degrees = 90
	else:
		royalVictory.rotation_degrees = 0

func _on_duckling_area_body_entered(body):
	if body is Player:
		body.rotation_degrees = rotation_degrees
		body.velocity = Vector2.ZERO
		showLabel(label_2)
		
		royalVictory_1.rotation_degrees += 90
		royalVictory_1.call_deferred("set_monitoring", true)
		
		royalVictory_2.rotation_degrees -= 90
		royalVictory_2.call_deferred("set_monitoring", true)
		
		royalVictory_1.rotation_degrees = 180
		royalVictory_1.call_deferred("set_monitoring", true)
		
		royalVictory_2.rotation_degrees = -90
		royalVictory_2.call_deferred("set_monitoring", true)
		
		royal_victory_6.rotation_degrees = 180
		royal_victory_6.call_deferred("set_monitoring", true)
		
		royalVictory.call_deferred("set_monitoring", true)
		royalVictory_4.call_deferred("set_monitoring", true)
		royalVictory_5.call_deferred("set_monitoring", true)

		staticBody.queue_free()
