extends Node2D
var damagetaken = 0
static var knockback = 0
var iframes = 0
var hitstun = 0

func _process(delta):
	if(iframes > 0):
		iframes-=delta*100
func take_damage(damage) -> void:
	if(iframes <= 0):
		print("ouch, " + str(damage) + " damage!")
		damagetaken += damage
		iframes = 1
