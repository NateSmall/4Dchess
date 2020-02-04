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

func get_type():
	return 'bishop'
	
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
	
func pathtilesempty(ptilecurrent, ptiletarget):
	var tcords = ptiletarget.get_cordinates()
	var ccords = self.get_cordinates()
	var pair = get_direction_pair_to(ptiletarget)
	var amount_moved_dir1 = tcords[pair[0]] - ccords[pair[0]]
	var amount_moved_dir2 = tcords[pair[1]] - ccords[pair[1]]
	if (-1 in pair):
		return false
	if (amount_moved_dir1 == amount_moved_dir2 or amount_moved_dir1 == -1 * amount_moved_dir2):
		for u in range(1, amount_moved_dir1 - 1):
			if (pair == [0,1]):
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0] + u, ccords[1] + u, ccords[2], ccords[3])
				if (tile_to_check.get_piece().get_type() != 'none'):
					return false
			elif (pair == [0,2]):
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0] + u, ccords[1], ccords[2] + u, ccords[3])
				if (tile_to_check.get_piece().get_type() != 'none'):
					return false
			elif (pair == [0,3]):
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0] + u, ccords[1], ccords[2], ccords[3] + u)
				if (tile_to_check.get_piece().get_type() != 'none'):
					return false
			elif (pair == [1,2]):
				print('test9 pass : ', u, ' ; ')
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1] + u, ccords[2] + u, ccords[3])
				if (tile_to_check.get_piece().get_type() != 'none'):
					print('test10 fail')
					return false
			elif (pair == [1,3]):
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1] + u, ccords[2], ccords[3] + u)
				if (tile_to_check.get_piece().get_type() != 'none'):
					return false
			elif (pair == [2,3]):
				var tile_to_check = ptilecurrent.get_parent().get_tile(ccords[0], ccords[1], ccords[2] + u, ccords[3] + u)
				if (tile_to_check.get_piece().get_type() != 'none'):
					return false
	else:
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
	if dims_moved != 2:
		return [-1, -1]
	else:
		return pair
			 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func final_tile_valid(ptiletarget):
	if (ptiletarget.get_piece().get_type() == 'none' or ptiletarget.get_piece().get_side() != side):
		return true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
