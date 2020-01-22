extends CollisionShape2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _init(size):
	var extvector = Vector2(size/2, size/2)
	var rec = RectangleShape2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
