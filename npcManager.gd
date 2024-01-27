extends Node3D

const npc = preload("res://scenes/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_npc = npc.instantiate()
	new_npc.setShirtColour(Color.from_hsv(randf(), 1, 1, 1))
	add_child(new_npc)
	position = Vector3 (15,0,randi() % 4 + 1)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta 
	

func spawnNPC():
	pass
