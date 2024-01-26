extends Control

signal start_game


func _ready():
	self.show()


func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_start_button_pressed():
	start_game.emit()
	self.hide()
