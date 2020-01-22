extends Sprite

var empty = preload('res://whitetile.png')
var b_k_txt = preload('res://black_king_icon.png')
var b_p_txt = preload('res://icon.png')

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

func gen_piece_type(side, piece):
	if (self.side == 'black'):
		if (self.piece.get_type() == 'pawn'):
			set_texture(b_p_txt)
		elif(self.piece.get):
			set_texture(b_k_txt)

func updateTexture():
	print(piece, " ll ")
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
