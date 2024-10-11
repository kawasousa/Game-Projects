extends Node

@onready var player = $"../Player"
@onready var fuel = player.current_fuel
@onready var max_fuel = player.fuel_capacity

var coal = 0
var coal_to_reload_fuel = 1

func add_coal():
	coal += 1
	if coal == coal_to_reload_fuel:
		fuel = max_fuel
