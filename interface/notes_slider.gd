extends Control


const ButtonIndicator = preload("res://interface/button_indicator.tscn")


func _ready():
	pass


func _process(delta):
	# Move the buttons left
	for b in $ButtonHolder.get_children():
		b.position.y = b.position.y + (delta * 240)
		if b.position.y > 1080:
			b.queue_free()


func add_new_button(pos : int) -> void:
	print("new note", pos)
	var new_button = ButtonIndicator.instantiate()
	new_button.position.y = 0
	if pos == 1:
		new_button.position.x = 5
	if pos == 2:
		new_button.position.x = 130
	if pos == 3:
		new_button.position.x = 255
	if pos == 4:
		new_button.position.x = 380
	if pos == 5:
		new_button.position.x = 5
	if pos == 6:
		new_button.position.x = 255
	new_button.set_track(pos)
	$ButtonHolder.add_child(new_button)


# 140 90
# 1005
func input_key(pressed_track : int) -> void:
	for b in $ButtonHolder.get_children():
		if b.position.y > 1005 - 120:
			if b.track == pressed_track:
				print(b.position.y - 1005 + 60)
				b.queue_free()
