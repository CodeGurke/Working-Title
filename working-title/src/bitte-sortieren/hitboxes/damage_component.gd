extends Node2D
static var damagetaken = 0
static var knockback = 0


func _ready():
	SignalBus.hit.connect(self.take_damage)

func take_damage(damage) -> void:
	print("ouch, " + str(damage) + " damage!")
	damagetaken += damage
