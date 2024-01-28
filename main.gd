extends Node3D

const title_screen_packed = preload("res://scenes/title_screen.tscn")
const player = preload("res://scenes/player.tscn")

# level
const newroad_packed = preload("res://scenes/newroad.tscn")


var title_screen = null
var current_level = null
var current_sequence : int
var current_instrument = null


@onready var eff : AudioEffectPitchShift = AudioServer.get_bus_effect(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_title_screen()
	print(eff)
	print(load_sequence("res://sequences/sequence_1.txt"))


func _create_title_screen():
	if current_level:
		current_level.queue_free()
		current_level = null
	$AIBusker.hide()
	$PlayerBusker.hide()
	if title_screen == null:
		title_screen = title_screen_packed.instantiate()
		title_screen.start_game.connect( self._on_title_screen_start_game )
		add_child(title_screen)
		title_screen.find_child("Camera3D").make_current()


func _on_title_screen_start_game():
	print("title screen start game")
	title_screen.queue_free()
	$NotesSlider.show()
	
	if current_level == null:
		current_level = newroad_packed.instantiate()
		add_child(current_level)
		current_level.find_child("Camera3D").make_current()

		# Place the player in the level
		var p_start = current_level.find_child("PlayerStart")
		assert(p_start)
		$PlayerBusker.transform = p_start.transform
		$PlayerBusker.show()

		# Place the opponent in the level
		var o_start = current_level.find_child("OpponentStart")
		assert(o_start)
		$AIBusker.transform = o_start.transform
		$AIBusker.show()

	current_instrument = load("res://instruments/Harmonica.tres")


func _input(event):
	if event is InputEventKey:
		# Show the main menu when pressing escape
		if event.keycode == KEY_ESCAPE:
			_create_title_screen()
			$NotesSlider.hide()
		# Otherwise pass the key to the debug visual
		if Input.is_action_just_pressed("ui_lane1"):
			$NotesSlider.input_key(1)
			$AudioStreamPlayer.stream = current_instrument.track_1
			$AudioStreamPlayer.play()
		if Input.is_action_just_pressed("ui_lane2"):
			$NotesSlider.input_key(2)
			$AudioStreamPlayer.stream = current_instrument.track_2
			$AudioStreamPlayer.play()
		if Input.is_action_just_pressed("ui_lane3"):
			$NotesSlider.input_key(3)
			$AudioStreamPlayer.stream = current_instrument.track_3
			$AudioStreamPlayer.play()
		if Input.is_action_just_pressed("ui_lane4"):
			$NotesSlider.input_key(4)
			$AudioStreamPlayer.stream = current_instrument.track_4
			$AudioStreamPlayer.play()
		#if Input.is_action_just_pressed("bongo_left"):
			#$NotesSlider.input_key(5)
		#if Input.is_action_just_pressed("bongo_right"):
			#$NotesSlider.input_key(6)


func load_sequence(file : String) -> Array:
	var f = FileAccess.open(file, FileAccess.READ)
	var s = f.get_as_text()
	return s.split("\n")
	
