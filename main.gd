extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_start_game():
	$NotesSlider.show()
	$Timer.start()
	$Newroad.show()


func _input(event):
	if event is InputEventKey:
		# Show the main menu when pressing escape
		if event.keycode == KEY_ESCAPE:
			$MainMenu.show()
			$NotesSlider.hide()
		# Otherwise pass the key to the debug visual
		if Input.is_action_just_pressed("ui_lane1"):
			$NotesSlider.input_key(1)
		if Input.is_action_just_pressed("ui_lane2"):
			$NotesSlider.input_key(2)
		if Input.is_action_just_pressed("ui_lane3"):
			$NotesSlider.input_key(3)
		if Input.is_action_just_pressed("ui_lane4"):
			$NotesSlider.input_key(4)
		#if Input.is_action_just_pressed("bongo_left"):
			#$NotesSlider.input_key(5)
		#if Input.is_action_just_pressed("bongo_right"):
			#$NotesSlider.input_key(6)

func _on_timer_timeout():
	$NotesSlider.add_new_button(randi_range(1,4))
