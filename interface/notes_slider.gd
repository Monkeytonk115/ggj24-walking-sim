extends Control


const ButtonIndicator = preload("res://interface/button_indicator.tscn")
const npc = preload("res://scenes/player.tscn")

var current_sequence = []
var current_sequence_i = 0

func _process(delta):
	# Move the buttons left
	for b in $ButtonHolder.get_children():
		b.position.y = b.position.y + (delta * 240)
		if b.position.y > 1080:
			b.queue_free()


# 140 90
# 1005
# Returns the score for this press
func input_key(pressed_track : int) -> float:
	for b in $ButtonHolder.get_children():
		if b.position.y > 1005 - 120:
			if b.track == pressed_track:
				print(b.position.y - 1005 + 60)
				b.queue_free()
				return atan(b.position.y - 1005 + 60)
	return -1.0

# Called from main to play the sequence
func play_sequence(sequence, bpm):
	current_sequence = sequence
	current_sequence_i = 0
	$Timer.wait_time = 60.0 / bpm
	$Timer.start()


func _on_timer_timeout():
	var note = 0
	if current_sequence_i < len(current_sequence):
		note = current_sequence[current_sequence_i]
	else:
		$Timer.stop()
		return
	print("new note ", note)
	current_sequence_i += 1
	
	# If the note is blank, we are not having a note here
	if note == 0:
		return
	
	# Else create a new button to put on the track
	var new_button = ButtonIndicator.instantiate()
	new_button.position.y = 0
	match note:
		1:
			new_button.position.x = 5
		2:
			new_button.position.x = 130
		3:
			new_button.position.x = 255
		4:
			new_button.position.x = 380
	
	new_button.set_track(note)
	$ButtonHolder.add_child(new_button)
