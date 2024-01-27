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
		b.position.y = b.position.y + (delta * 240)
		if b.position.y > 1080:
			b.queue_free()


func add_new_button(pos : int) -> void:
	var new_button = ButtonIndicator.instantiate()
	new_button.position.y = 0
	if pos == 1:
		new_button.position.x = 5
		new_button.texture = button_1
	if pos == 2:
		new_button.position.x = 130
		new_button.texture = button_2
	if pos == 3:
		new_button.position.x = 255
		new_button.texture = button_3
	if pos == 4:
		new_button.position.x = 380
		new_button.texture = button_4
	$ButtonHolder.add_child(new_button)


# 140 90
# 1005
func input_key(key : String) -> void:
	for b in $ButtonHolder.get_children():
		if b.position.y > 1005 - 120:
			print(b.position.y - 1005 + 60)
			b.queue_free()
