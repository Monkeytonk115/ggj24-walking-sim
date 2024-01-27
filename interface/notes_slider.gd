extends Control


const ButtonIndicator = preload("res://interface/button_indicator.tscn")

@export var button_1 : Texture2D
@export var button_2 : Texture2D
@export var button_3 : Texture2D
@export var button_4 : Texture2D

@onready var _buttons = []

func _ready():
	pass


func _process(delta):
	# Move the buttons left
	for b in $ButtonHolder.get_children():
		b.position.x = b.position.x - (delta * 240)
		if b.position.x < 0:
			b.queue_free()


func add_new_button(pos : int) -> void:
	var new_button = ButtonIndicator.instantiate()
	new_button.position.x = 1900
	if pos == 1:
		new_button.position.y = 25
		new_button.texture = button_1
	if pos == 2:
		new_button.position.y = 85
		new_button.texture = button_2
	if pos == 3:
		new_button.position.y = 150
		new_button.texture = button_3
	if pos == 4:
		new_button.position.y = 220
		new_button.texture = button_4
	$ButtonHolder.add_child(new_button)
