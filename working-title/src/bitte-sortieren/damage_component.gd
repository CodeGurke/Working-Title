extends Node2D
var damagetaken
var knockback
func _ready():
	connect("hit",self.take_damage)

func take_damage(damage:int) -> void:
	print("ouch, " + str(damage) + " damage!")
	damagetaken += damage
