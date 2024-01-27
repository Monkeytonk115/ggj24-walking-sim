extends Control

@export var texture_1 : Texture2D
@export var texture_2 : Texture2D
@export var texture_3 : Texture2D
@export var texture_4 : Texture2D
@export var texture_wide : Texture2D

var track = 0

func set_track(index : int) -> void:
	self.track = index
	if index == 1:
		$TextureRect.texture = texture_1
	if index == 2:
		$TextureRect.texture = texture_2
	if index == 3:
		$TextureRect.texture = texture_3
	if index == 4:
		$TextureRect.texture = texture_4
	if index == 5:
		$TextureRect.texture = texture_wide
	if index == 6:
		$TextureRect.texture = texture_wide
