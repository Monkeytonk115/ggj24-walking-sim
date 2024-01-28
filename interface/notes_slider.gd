extends Control

signal sequence_complete

const ButtonIndicator = preload("res://interface/button_indicator.tscn")
const npc = preload("res://scenes/player.tscn")

var current_sequence = []

var playing_sequence = false

func _process(delta):
	# Move the buttons left
	for b in $ButtonHolder.get_children():
		b.position.y = b.position.y + (delta * 360)
		if b.position.y > 1080:
			b.queue_free()
	if playing_sequence and $ButtonHolder.get_child_count() == 0 and len(current_sequence) == 0:
		playing_sequence = false
		sequence_complete.emit()


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
	playing_sequence = true
	$Timer.wait_time = 30.0 / bpm
	$Timer.start()


func _on_timer_timeout():
	var note = 0
	if len(current_sequence) > 0:
		note = current_sequence.pop_front()
	else:
		$Timer.stop()
		return
	print("new note ", note)
	
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
