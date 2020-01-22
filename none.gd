extends Sprite

var txt = preload("res://whitetile.png")

func __init():
	pass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_txt():
	return txt
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_type():
	return "none"
	
func get_side():
	return 'n'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
