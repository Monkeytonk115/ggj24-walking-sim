extends Node3D

# Humanoid parameters
@export var torso : String
@export var hair : String
@export var arms : String
@export var legs : String
@export var shoe : String


func _ready():
	pass
	# TODO: make the humanoid change based on the parameters given


func _process(delta):
	pass
	# TODO: make the humanoid do things like walk around

func setShirtColour(shirtColour):
	$body.get_surface_override_material(0).albedo_color = shirtColour
	$body.get_surface_override_material(0).albedo_texture = null
	

func npcMove():
	pass
