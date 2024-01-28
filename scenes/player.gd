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
			($head as MeshInstance3D).rotate_y(1 * delta)
			($head as MeshInstance3D).look_at(Vector3(0,0,0),Vector3(0,1,0))
			$AnimationPlayer.play("npcWalk")
		else:
			queue_free()

func setShirtColour(shirtColour):
	var new_mat = StandardMaterial3D.new()
	new_mat.albedo_color = shirtColour
	$body.set_surface_override_material(0, new_mat)


func npcMove():
	destination = position + Vector3(-5,0,0)
	
	
