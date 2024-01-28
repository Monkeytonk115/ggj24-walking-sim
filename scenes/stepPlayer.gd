extends AnimationPlayer

var foot1 = preload("res://audio/foots-001.ogg")
var audio

# Called when the node enters the scene tree for the first time.
func _ready():
	audio = get_node("player/body/AudioStreamPlayer3D")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func step():
	var randNumber = randi() % 4
	if randNumber == 0:
		audio.set_stream(foot1)
		audio.play()
