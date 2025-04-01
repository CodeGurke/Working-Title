class_name HurtBox
extends Area2D


var team = 0

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	

func _ready() -> void:
	connect("area_entered",self.on_area_entered)
	
	
func on_area_entered(hitbox:HitBox) -> void:
	print("area entered")
	if(hitbox != null):
		SignalBus.hit.emit(hitbox.damage)
	
	
