extends Sprite

var wpos
var xpos
var ypos
var zpos
var piecetextureb = preload("res://brook.jpeg")
var piecetexturew = preload('res://wrook.jpeg')
var side
var noneclass = preload("none.gd")
var hltxtw = preload("res://HLwrook.png")
var hltxtb = preload("HLbrook.png")

func _init(pw, px, py, pz, pside):
	wpos = pw
	xpos = px
	ypos = py
	zpos = pz
	self.side = pside

func get_highlight_txt():
	if (side == 'b'):
		return hltxtb
	else:
		return hltxtw

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
	
func move(ptilecurrent, ptiletarget):
	if (moveValid(ptilecurrent, ptiletarget)):
		ptiletarget.set_piece(self)
		var nonepiece = noneclass.new()
		ptilecurrent.set_piece(nonepiece)
		var newCords = ptiletarget.get_cordinates()
		self.set_cordinates(newCords[0], newCords[1], newCords[2], newCords[3])
		return true
	return false
		
func moveValid(ptilecurrent, ptiletarget):
	if (ptilecurrent.get_piece().get_type() == 'none'):
		return false
	if (pathtilesempty(ptilecurrent, ptiletarget) and final_tile_valid(ptiletarget)):
		return true
	return false
	
func final_tile_valid(ptiletarget):
	if (ptiletarget.get_piece().get_type() == 'none' or ptiletarget.get_piece().get_side() != side):
		return true
	else:
		return false
	
func pathtilesempty(ptilecurrent, ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var direc = get_direction_to(ptiletarget)
	print(direc)
	if direc == -1:
		return false
	elif direc == 0:
		if (ccords[0] + 2 == tcords[0]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0] + 1, ccords[1], ccords[2], ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 1:
		if (ccords[1] + 2 == tcords[1]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1] + 1, ccords[2], ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 2:
		if (ccords[2] + 2 == tcords[2]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2] + 1, ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 3:
		if (ccords[3] + 2 == tcords[3]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2], ccords[3] + 1)
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 4:
		if (ccords[0] - 2 == tcords[0]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0] - 1, ccords[1], ccords[2], ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 5:
		if (ccords[1] - 2 == tcords[1]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1] - 1, ccords[2], ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 6:
		if (ccords[2] - 2 == tcords[2]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2] - 1, ccords[3])
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	elif direc == 7:
		if (ccords[3] - 2 == tcords[3]):
			var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2], ccords[3] - 1)
			if (tile_to_check.get_piece().get_type() != 'none'):
				return false
	return true
	
func get_direction_to(ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var dims_moved = 0
	for x in range(len(tcords)):
		if tcords[x] != ccords[x]:
			dims_moved += 1
	if (dims_moved != 1):
		return -1
	for x in range(len(tcords)):
		if tcords[x] > ccords[x]: 
			return x
		elif tcords[x] < ccords[x]:
			return 4 + x

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
