extends Sprite

var wpos
var xpos
var ypos
var zpos
var piecetexturew = preload('res://wbishop.jpeg')
var piecetextureb = preload('res://bbishop.jpeg')
var side
var noneclass = preload("none.gd")

func _init(pw, px, py, pz, pside):
	wpos = pw
	xpos = px
	ypos = py
	zpos = pz
	self.side = pside

func get_txt():
	if (side == 'b'):
		return piecetextureb
	else:
		return piecetexturew
		
func get_cordinates():
	var poslist = [wpos, xpos, ypos, zpos]
	return poslist
	
func set_cordinates(pwpos, pxpos, pypos, pzpos):
	wpos = pwpos
	xpos = pxpos
	ypos = pypos
	zpos = pzpos
	
func get_side():
	return side
	
func move(ptilecurrent, ptiletarget) -> void:
	if (moveValid(ptilecurrent, ptiletarget)):
		ptiletarget.set_piece(self)
		var nonepiece = noneclass.new()
		ptilecurrent.set_piece(nonepiece)
		var newCords = ptiletarget.get_cordinates()
		self.set_cordinates(newCords[0], newCords[1], newCords[2], newCords[3])
		
func moveValid(ptilecurrent, ptiletarget):
	if (ptilecurrent.get_piece().get_type() == 'none'):
		return false
	if (pathtilesempty(ptilecurrent, ptiletarget) and final_tile_valid(ptiletarget)):
		return true
	return false
	
func pathtilesempty(ptilecurrent, ptiletarget):
	pass
	
func get_direction_pair_to(ptiletarget):
	#returns two of -1 0 1 2 3
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var dims_moved = 0
	var pair = [-1, -1]
	for u in range(len(ccords)):
		if ccords[u] != tcords[u]:
			dims_moved += 1
			for place in pair:
				if place != -1:
					place = u
					break
	
			 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func final_tile_valid(ptiletarget):
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
