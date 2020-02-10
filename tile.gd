extends Sprite

var empty = preload('res://whitetile.png')
var green_tile = preload('green_tile.png')

var wpos
var xpos
var ypos
var zpos
var piece
var side

class_name tile

func _init(pwpos, pxpos, pypos, pzpos, ppiece):
	self.piece = ppiece
	self.wpos = pwpos
	self.xpos = pxpos
	self.ypos = pypos
	self.zpos = pzpos
	self.set_texture(self.empty)

func get_piece():
	return piece

func set_piece(ppiece) -> void:
	self.piece = ppiece
	self.updateTexture()

func hilight():
	self.set_texture(piece.get_highlight_txt())

func unhilight():
	self.set_texture(piece.get_txt())

func updateTexture():
	self.set_texture(piece.get_txt())
	
func get_cordinates():
	return [wpos, xpos, ypos, zpos]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
# func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
