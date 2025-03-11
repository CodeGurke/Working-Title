class_name HitBox
extends Area2D

@export var damage := 10
@export var team := 0

func _init() -> void:
	collision_layer = 1
	collision_mask = 1
