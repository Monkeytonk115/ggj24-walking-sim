extends Node3D

var destination
var moveMultiplier

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
			position.x -= 0.03 * moveMultiplier
			#($head as MeshInstance3D).rotate_y(1 * delta)
			($head as MeshInstance3D).look_at(Vector3(0,0,0),Vector3(0,1,0))
			
		else:
			queue_free()

func setShirtColour(shirtColour):
	var new_mat = StandardMaterial3D.new()
	new_mat.albedo_color = shirtColour
	$body.set_surface_override_material(0, new_mat)


func npcMove():
	destination = position + Vector3(-5,0,0)
	moveMultiplier = randi() % 9 + 1
	$AnimationPlayer.play("npc walk")
	$AnimationPlayer.speed_scale = 4 * moveMultiplier


# Animate holstering instrument
func holster_instrument():
	pass


# Animate drawing instrument
func draw_instrument(instrument : Instrument):
	pass


# Play the instrument sequence at the bpm
func play_instrument(sequence : Array, bpm : int):
	pass
