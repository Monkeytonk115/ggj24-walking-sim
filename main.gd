extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_start_game():
	pass # Replace with function body.


func _input(event):
	if event is InputEventKey:
		# Show the main menu when pressing escape
		if event.keycode == KEY_ESCAPE:
			$MainMenu.show()
		# Otherwise pass the key to the debug visual
		if event.pressed:
			var text = OS.get_keycode_string(event.keycode)
			print(text)
			$DebugVisualPrompt.update_text(text)
