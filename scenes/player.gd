extends Node3D

var destination

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
	if destination:
		if destination != position:
			position.x -= 0.03
		else:
			queue_free()

func setShirtColour(shirtColour):
	var new_mat = StandardMaterial3D.new()
	new_mat.albedo_color = shirtColour
	$body.set_surface_override_material(0, new_mat)


func npcMove():
	destination = position + Vector3(-5,0,0)
	
	
