extends CanvasLayer

@onready var fuel_indicator = $fuel_label


func _process(_delta):
	var fuel = $"../Player".current_fuel
	fuel_indicator.text = "Combustível: " + str(fuel)
