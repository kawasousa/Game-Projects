extends Node2D

@onready var fuelb = $Player.fuel
@onready var fuel_indicator = $HUD/fuel_indicator

func _process(delta):
	fuel_indicator.text = "combustível:" + str()
