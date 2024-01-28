extends Node3D

const title_screen_packed = preload("res://scenes/title_screen.tscn")
const player = preload("res://scenes/player.tscn")

# level
const newroad_packed = preload("res://scenes/newroad.tscn")


var title_screen = null
var current_level = null

var current_instrument = null
var current_sequence : Array = []
var current_sequence_busker_i = 0
var current_bpm = 120

var ai_busker_instrument
var player_busker_instrument

var score : float = 0.0

var game_state

@onready var eff : AudioEffectPitchShift = AudioServer.get_bus_effect(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_title_screen()
	#print(eff)
	#'print(load_sequence("res://sequences/sequence_1.txt"))


func _create_title_screen():
	if current_level:
		current_level.queue_free()
		current_level = null
	$NotesSlider.hide()
	$AIBusker.hide()
	$PlayerBusker.hide()
	$Timer.stop()
	$TimerBuskerPlayback.stop()
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

	game_state = "start"
	score = 0.0
	$NotesSlider.update_score_label(score)
	current_bpm = 120
	$Timer.wait_time = 1
	$Timer.start()
	print($Timer)

func _input(event):
	if event is InputEventKey:
		# Show the main menu when pressing escape
		if event.keycode == KEY_ESCAPE:
			_create_title_screen()
		if game_state == "player_play":
			if Input.is_action_just_pressed("ui_lane1"):
				score += $NotesSlider.input_key(1)
				player_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_1
				$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("ui_lane2"):
				score += $NotesSlider.input_key(2)
				player_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_2
				$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("ui_lane3"):
				score += $NotesSlider.input_key(3)
				player_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_3
				$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("ui_lane4"):
				score += $NotesSlider.input_key(4)
				player_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_4
				$AudioStreamPlayer.play()
			$NotesSlider.update_score_label(score)
			


# Load a sequence file into an array of length 16
func load_sequence(file : String) -> Array:
	print(file)
	var f = FileAccess.open(file, FileAccess.READ)
	var s = f.get_as_text()
	var output_sequence = []
	for l in s.split("\n"):
		if l == "":
			output_sequence.append(0)
		else:
			output_sequence.append(int(l))
	return output_sequence


func _on_timer_timeout():
	print("timeout state: ", game_state)
	match game_state:
		"start":
			var p_start = current_level.find_child("PlayerStart")
			var o_start = current_level.find_child("OpponentStart")
			match randi() % 4:
				0:
					current_instrument = load("res://instruments/Fiddle.tres")
					player_busker_instrument = p_start.find_child("fiddle")
					ai_busker_instrument = o_start.find_child("fiddle")
				1:
					current_instrument = load("res://instruments/Harmonica.tres")
					player_busker_instrument = p_start.find_child("harmonica")
					ai_busker_instrument = o_start.find_child("harmonica")
				2:
					current_instrument = load("res://instruments/Percussion.tres")
					player_busker_instrument = p_start.find_child("bongo")
					ai_busker_instrument = o_start.find_child("bongo")
				3:
					current_instrument = load("res://instruments/Tuba.tres")
					player_busker_instrument = p_start.find_child("tuba")
					ai_busker_instrument = o_start.find_child("tuba")
			current_sequence = load_sequence("res://sequences/sequence_%d.txt" % randi_range(1, 8))
			game_state = "opponent_play"
			$Timer.wait_time = 1
		"opponent_play":
			$Timer.stop()
			current_sequence_busker_i = 0
			$TimerBuskerPlayback.wait_time = 30.0 / current_bpm
			$TimerBuskerPlayback.start()
		"player_play":
			$NotesSlider.play_sequence(current_sequence, current_bpm)
			$Timer.stop()
		"end":
			print("score: ", score)
			game_state = "start"
			$Timer.wait_time = 1


func _on_notes_slider_sequence_complete():
	game_state = "end"
	$Timer.wait_time = 1
	$Timer.start()


func _on_timer_busker_playback_timeout():
	if current_sequence_busker_i < len(current_sequence):
		match current_sequence[current_sequence_busker_i]:
			1:
				ai_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_1
				$AudioStreamPlayer.play()
			2:
				ai_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_2
				$AudioStreamPlayer.play()
			3:
				ai_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_3
				$AudioStreamPlayer.play()
			4:
				ai_busker_instrument.find_child("Animation").play("play")
				$AudioStreamPlayer.stream = current_instrument.track_4
				$AudioStreamPlayer.play()
	else:
		game_state = "player_play"
		$Timer.wait_time = 1
		$Timer.start()
		$TimerBuskerPlayback.stop()
	current_sequence_busker_i += 1


func _on_notes_slider_missed():
	$Timer.stop()
	$TimerBuskerPlayback.stop()
	$Failscreen.set_score(score)
	$Failscreen.show()
