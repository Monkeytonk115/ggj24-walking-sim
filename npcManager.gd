extends Node3D

const npc = preload("res://scenes/player.tscn")
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	position 
	
	$Timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x -= delta 
	pass
	


func _on_timer_timeout():
	var new_npc = npc.instantiate()
	new_npc.setShirtColour(Color.from_hsv(randf(), 1, 1, 1))
	new_npc.position = Vector3 (5,0,randi() % 4 + 1)
	add_child(new_npc)
	new_npc.npcMove()
