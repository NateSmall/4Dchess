extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var size
var w
var x
var y
var z

func _init(pw, px, py, pz):
	self.w = pw
	self.x = px
	self.y = py
	self.z = pz
	self.size = 100

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
    	self.on_click()

func on_click():
	#temp
	print(get_children())
	self.get_parent().handle_click(self)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Vector2(x * 110 + z * 350 + 100, y * 110 + w * 350 + 50)

func get_piece(w, x, y, z):
	var child = get_child(0)
	return child.get_piece()
	
func get_tile(w, x, y, z):
	return self.get_parent().get_tile(w, x, y, z)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
