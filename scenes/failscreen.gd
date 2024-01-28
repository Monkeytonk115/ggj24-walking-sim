extends Control

func _on_button_pressed():
	get_tree().quit()

func set_score(score):
	$Panel2/Label.text = "score: %d" % score
