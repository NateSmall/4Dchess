extends Sprite

var wpos
var xpos
var ypos
var zpos
var piecetextureb = preload("res://brook.jpeg")
var piecetexturew = preload('res://wrook.jpeg')
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
	
func final_tile_valid(ptiletarget):
	if (ptiletarget.get_piece().get_type() == 'none' or ptiletarget.get_piece().get_side() != side):
		return true
	
func pathtilesempty(ptilecurrent, ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var direc = get_direction_to(ptiletarget)
	if direc == -1:
		return false
	elif (direc == 0): #w
		for w in range(ccords[0] + 1, tcords[0]):
			var tiletocheck = ptilecurrent.get_parent().get_tile(w, ccords[1], ccords[2], ccords[3])
			if (tiletocheck.get_piece().get_type() != 'none'):
				return false
	elif (direc == 1): #x
		for x in range(ccords[0] + 1, tcords[0]):
			var tiletocheck = ptilecurrent.get_parent().get_tile(ccords[0], x, ccords[2], ccords[3])
			if (tiletocheck.get_piece().get_type() != 'none'):
				return false
	elif (direc == 2):
		for y in range(ccords[0] + 1, tcords[0]):
			var tiletocheck = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], y, ccords[3])
			if (tiletocheck.get_piece().get_type() != 'none'):
				return false
	elif (direc == 3):
		for z in range(ccords[0] + 1, tcords[0]):
			var tiletocheck = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2], z)
			if (tiletocheck.get_piece().get_type() != 'none'):
				return false
	return true
	
func get_direction_to(ptiletarget):
	#returns -1 0 1 2 3
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var dims_moved = 0
	for x in range(len(tcords)):
		if tcords[x] != ccords[x]:
			dims_moved += 1
	if (dims_moved != 1):
		return -1
	for x in range(len(tcords)):
		if tcords[x] != ccords[x]: 
			return x
	return dims_moved

func get_type():
	return 'rook'
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
