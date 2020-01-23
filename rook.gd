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
	if (ptilecurrent.getpiece().get_type() == 'none'):
		return false
	if (pathtilesempty(ptilecurrent, ptiletarget)):
		return true
	return false
	
func pathtilesempty(ptilecurrent, ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var direc = get_direction_to(ptiletarget)
	if direc == -1:
		return false
	elif (direc == 0): #w
		for w in range(tcords[0] + 1, ccords[0] + 1):
			var tiletocheck = ptilecurrent.get_tile(w, ccords[1], ccords[2], ccords[3])
			if (tiletocheck.get_piece().get_type() == 'none' or tiletocheck.get_piece().get_side() != side):
				return true
	elif (direc == 1): #x
		pass
	elif (direc == 2):
		pass
	elif (direc == 3):
		pass
	
func get_direction_to(ptiletarget):
	#returns -1 0 1 2 3
	var tcords = ptiletarget.get_codinates()
	var ccords = self.get_cordinates()
	var dims_moved = 0
	for x in range(len(tcords)):
		if tcords[x] != ccords[x]:
			dims_moved += 1
	if (dims_moved != 1):
		return false
	for x in range(len(tcords)):
		if tcords[x] != ccords[x]: 
			return x
	return dims_moved

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
