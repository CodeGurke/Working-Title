class_name Bodypart
extends Stats

# This script is used as a resource to define new bodyparts
# Every value is defined as a export variable so it can be easily set inside the inspector of a resource

@export_enum("legs", "body", "head", "hand") var type : String
@export var name : String
@export var sprite : Texture
@export var width : int
@export var height : int
