extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wpos
var xpos
var ypos
var zpos
var piecetexturew = preload('res://wpawn.jpeg')
var piecetextureb = preload('res://bpawn.jpeg')
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
	if (moveValid(ptilecurrent, ptiletarget) or attackValid(ptiletarget)):
		ptiletarget.set_piece(self)
		var nonepiece = noneclass.new()
		ptilecurrent.set_piece(nonepiece)
		var newCords = ptiletarget.get_cordinates()
		self.set_cordinates(newCords[0], newCords[1], newCords[2], newCords[3])
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func moveValid(ptilecurrent, ptiletarget):
	if (ptilecurrent.get_piece().get_type() == 'none'):
		return false
	print(pathTilesEmpty(ptiletarget), ' / ', validMoveForPiece(ptiletarget))
	print(pathTileEnemy(ptiletarget), " <> ", validAttackForPiece(ptiletarget))
	if (pathTilesEmpty(ptiletarget) and validMoveForPiece(ptiletarget)):
		return true
		
func attackValid(ptile):
	if (pathTileEnemy(ptile) and validAttackForPiece(ptile)):
		return true
		
func pathTilesEmpty(ptiletarget):
	if (ptiletarget.get_piece().get_type() == 'none'):
		return true
	
func pathTileEnemy(ptiletarget):
	if (ptiletarget.get_piece().get_side() != get_side() and ptiletarget.get_piece().get_side() != 'n'):
		return true
	
# can move 1 tile in w or y
func validMoveForPiece(ptileTarget):
	var tcords = ptileTarget.get_cordinates()
	print(side)
	if (side == 'b'):
		print('unfilled side')
	elif (side == 'w'):
		var ccords = self.get_cordinates()
		var dimentionsmoved = 0
		if (ccords[0] + 1 == tcords[0]):
			if (ccords[1] == tcords [1] and ccords[3] == tcords[3]):
				return true
		elif (ccords[2] + 1 == tcords[2]):
			if (ccords[1] == tcords [1] and ccords[3] == tcords[3]):
				return true
		return false
			
func validAttackForPiece(ptileTarget):
	var tcords = ptileTarget.get_cordinates()
	print(side)
	var ccords = self.get_cordinates()
	if (side == 'b'):
		print('unfilled side')
	elif (side == 'w'):
		# if moving forward in w
		if (ccords[0] + 1 == tcords[0]):
			print(4)
			if (ccords[1] + 1 == tcords[1] or ccords[1] - 1 == tcords[1]):
				if (ccords[3] == tcords[3] and ccords[2] == tcords[2]):
					return true
			elif (ccords[3] + 1 == tcords[3] or ccords[3] - 1 == tcords[3]):
				if (ccords[1] == tcords[1] and ccords[2] == tcords[2]):
					return true
		# if moving forward in y
		elif (ccords[2] + 1 == tcords[2]):
			print(3)
			if (ccords[1] + 1 == tcords[1] or ccords[1] - 1 == tcords[1]):
				if (ccords[3] == tcords[3] and ccords[0] == tcords[0]):
					return true
			elif (ccords[3] + 1 == tcords[3] or ccords[3] - 1 == tcords[3]):
				if (ccords[1] == tcords[1] and ccords[0] == tcords[0]):
					return true

func get_type():
	return 'pawn'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
