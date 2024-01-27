extends Node3D

const npc = preload("res://scenes/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_npc = npc.instantiate()
	new_npc.setShirtColour(Color(randi() % 255,randi() % 255,randi() % 255,1))
	add_child(new_npc)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
