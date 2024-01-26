extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = ""


func update_text(new_text : String) -> void:
	$Label.text = new_text
