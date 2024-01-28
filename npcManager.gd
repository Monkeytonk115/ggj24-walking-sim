extends Node3D

const npc = preload("res://scenes/player.tscn")


func _ready():
	$Timer.start()


func _on_timer_timeout():
	var new_npc = npc.instantiate()
	new_npc.setShirtColour(Color.from_hsv(randf(), 1, 1, 1))
	new_npc.position = Vector3 (15,0,randi() % 4 + 1)
	add_child(new_npc)
	new_npc.npcMove()
