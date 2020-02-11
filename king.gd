extends Sprite

var wpos
var xpos
var ypos
var zpos
var piecetexturew = preload('res://wking.jpeg')
var piecetextureb = preload('res://black_king_icon.png')
var side
var noneclass = preload("none.gd")
var hltxtw = preload("HLwking.png")
var hltxtb = preload("HLbking.png")

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

func get_type():
	return 'king'
	
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
	if (final_tile_valid(ptiletarget) and not_to_far(ptilecurrent, ptiletarget)):
		return true
	return false

func final_tile_valid(ptiletarget):
	if not (ptiletarget.get_piece().get_type() == 'none' or ptiletarget.get_piece().get_side() != side):
		return false
	return true
	
func not_to_far(ptilecurrent, ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var pair = get_direction_pair_to(ptiletarget)
	if pair == [-1, -1]:
		return false
	for x in range(len(tcords)):
		if (ccords[x] - tcords[x]) > 1 or (ccords[x] - tcords[x]) < -1:
			return false
	return true
	
func get_direction_pair_to(ptiletarget):
	#returns two of -1 0 1 2 3
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var dims_moved = 0
	var pair = [-1, -1]
	for u in range(len(ccords)):
		if ccords[u] != tcords[u]:
			dims_moved += 1
			for r in range(2):
				if pair[r] == -1:
					pair[r] = u
					break
	if dims_moved != 2 and dims_moved != 1:
		return [-1, -1]
	else:
		return pair
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
