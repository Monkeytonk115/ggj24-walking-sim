extends Node3D

var _noise
var _time


# Called when the node enters the scene tree for the first time.
func _ready():
	self._time = 0
	self._noise = FastNoiseLite.new()
	
	$player/AnimationPlayer.play("bopping")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self._time += delta
	
	# Rotate speed is delta so framerate independed
	# 3 so it's not too slow
	# noise so it's random
	# elapsed time so it speeds up
	var rotate_speed = delta * \
		3 * \
		(self._noise.get_noise_1d(self._time)) * \
		min(12, (self._time + 1) * 0.1)
	($harmonica as Node3D).rotate(Vector3(0,0.4,0.6).normalized(), rotate_speed)


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_exit_button_pressed():
	pass # Replace with function body.
