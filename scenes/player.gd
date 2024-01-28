extends Node3D

var destination
var moveMultiplier
#var audio
#var foot1 = preload("res://audio/foots-001.ogg")

# Humanoid parameters
@export var torso : String
@export var hair : String
@export var arms : String
@export var legs : String
@export var shoe : String


func _ready():
	#audio = get_node("body/AudioStreamPlayer3D")
	pass
	# TODO: make the humanoid change based on the parameters given


func _process(delta):
	if destination:
		if destination != position:
			position.x -= 0.03 * moveMultiplier
			#($head as MeshInstance3D).rotate_y(1 * delta)
			($head as MeshInstance3D).look_at(Vector3(0,0,0), Vector3(-1,1,0), true)
			
		else:
			queue_free()

func setShirtColour(shirtColour):
	var new_mat = StandardMaterial3D.new()
	new_mat.albedo_color = shirtColour
	$body.set_surface_override_material(0, new_mat)


func npcMove():
	destination = position + Vector3(-5,0,0)
	moveMultiplier = randi() % 5 + 1
	$AnimationPlayer.play("npc walk")
	$AnimationPlayer.speed_scale = 4 * moveMultiplier


func step():
	#print("step")
	#var randNumber = randi() % 4
	#if randNumber == 0:
		#$body/AudioStreamPlayer3D.set_stream(foot1)
		#$body/AudioStreamPlayer3D.play()
	pass
