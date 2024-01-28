extends Node3D

const title_screen_packed = preload("res://scenes/title_screen.tscn")
const player = preload("res://scenes/player.tscn")

# level
const newroad_packed = preload("res://scenes/newroad.tscn")


var title_screen = null
var current_level = null
var current_sequence : int


@onready var eff : AudioEffectPitchShift = AudioServer.get_bus_effect(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_title_screen()
	print(eff)


func _create_title_screen():
	if current_level:
		current_level.queue_free()
		current_level = null
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
	
	$AudioStreamPlayer.stream = load("res://scenes/InstrumentSine.tres").base_note


func _input(event):
	if event is InputEventKey:
		# Show the main menu when pressing escape
		if event.keycode == KEY_ESCAPE:
			_create_title_screen()
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
