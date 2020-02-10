extends Node2D

var pawn = preload("pawn.gd")
var tileclass = load("tile.gd")
var tileareaclass = load("TileArea2D.gd")
var tilecollsionclass = load("res://TileCollisionShape2D.gd")
var none = preload("none.gd")
var rook = preload('rook.gd')
var bishop = preload("bishop.gd")
var knight = preload("knight.gd")
var king = preload('king.gd')
var queen = preload('queen.gd')
var gameOver = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boardDimention = 3
var tileArray = []
var tileAreaArray = []
var firstclickused = false
var firstclick = null
var secondclickused = false
var secondclick = null
var firstclickpiece = null
var blackturn = false
#		for z in range(boardDimention):
#			tileArray[x][y]

# Called when the node enters the scene tree for the first time.
func _ready():
	for w in range(boardDimention):
		tileAreaArray.append([])
		for x in range(boardDimention):
			tileAreaArray[w].append([])
			for y in range(boardDimention):
				tileAreaArray[w][x].append([])
				for z in range(boardDimention):
					tileAreaArray[w][x][y].append([])
					tileAreaArray[w][x][y][z] = tileareaclass.new(w, x, y, z)
					self.add_child(tileAreaArray[w][x][y][z])
	for w in range(boardDimention):
		tileArray.append([])
		for x in range(boardDimention):
			tileArray[w].append([])
			for y in range(boardDimention):
				tileArray[w][x].append([])
				for z in range(boardDimention):
					tileArray[w][x][y].append([])
					var nonepiece = none.new()
					tileArray[w][x][y][z] = tile.new(w, x, y, z, nonepiece)
					self.add_child(tileAreaArray[w][x][y][z])
					tileAreaArray[w][x][y][z].add_child(tileArray[w][x][y][z])
					var rec = RectangleShape2D.new()
					rec.set_extents(Vector2(50, 50))
					var collision = CollisionShape2D.new()
					collision.set_shape(rec)
					tileAreaArray[w][x][y][z].add_child(collision)
	var wp1 = pawn.new(0, 0, 1, 0, 'w')
	var wp2 = pawn.new(0, 1, 1, 0, 'w')
	#var wp3 = pawn.new(0, 2, 1, 0, 'w')
	var wp4 = pawn.new(0, 0, 1, 1, 'w')
	var wp5 = pawn.new(0, 1, 1, 1, 'w')
	var wp6 = pawn.new(0, 2, 1, 1, 'w')
	#var wp7 = pawn.new(0, 0, 1, 2, 'w')
	var wp8 = pawn.new(0, 1, 1, 2, 'w')
	var wp9 = pawn.new(0, 2, 1, 2, 'w')
	var wb1 = bishop.new(0, 0, 0, 1, 'w')
	var wb2 = bishop.new(0, 2, 0, 1, 'w')
	var wk1 = knight.new(0, 1, 0, 0, 'w')
	#var wk2 = knight.new(0, 1, 0, 2, 'w')
	var wr1 = rook.new(0, 0, 0, 0, 'w')
	var wr2 = rook.new(0, 2, 0, 2, 'w')
	var wk = king.new(0, 1, 0, 1, 'w')
	var wq = queen.new(0, 1, 0, 2, 'w')
	#var wk3 = knight.new(0, 1, 0, 2, 'w')
	var bp1 = pawn.new(2, 0, 1, 0, 'b')
	var bp2 = pawn.new(2, 1, 1, 0, 'b')
	#var bp3 = pawn.new(0, 2, 1, 0, 'w')
	var bp4 = pawn.new(2, 0, 1, 1, 'b')
	var bp5 = pawn.new(2, 1, 1, 1, 'b')
	var bp6 = pawn.new(2, 2, 1, 1, 'b')
	#varbwp7 = pawn.new(0, 0, 1, 2, 'w')
	var bp8 = pawn.new(2, 1, 1, 2, 'b')
	var bp9 = pawn.new(2, 2, 1, 2, 'b')
	var bb1 = bishop.new(2, 0, 2, 1, 'b')
	var bb2 = bishop.new(2, 2, 2, 1, 'b')
	var bk1 = knight.new(2, 1, 2, 2, 'b')
	#var bk2 = knight.new(0, 1, 0, 2, 'w')
	var br1 = rook.new(2, 0, 2, 0, 'b')
	var br2 = rook.new(2, 2, 2, 2, 'b')
	var bk = king.new(2, 1, 2, 1, 'b')
	var bq = queen.new(2, 1, 2, 0, 'b')
	#var bk3 = knight.new(0, 1, 0, 2, 'w')
	place_pieces([wp1, wp2, wp4, wp5, wp6, wp8, wp9, wb1, wb2, wk1, wr1, wr2, wk, wq])
	place_pieces([bp1, bp2, bp4, bp5, bp6, bp8, bp9, bb1, bb2, bk1, br1, br2, bk, bq])
	
func place_pieces(ppieces):
	for piece in ppieces:
		place_piece(piece)
		
func create_new_queen(ppawn):
	var pcords = ppawn.get_cordinates()
	var newqueen1 = queen.new(pcords[0], pcords[1], pcords[2], pcords[3], ppawn.get_side())
	place_piece(newqueen1)

func place_piece(ppiece):
	var cordinates = ppiece.get_cordinates()
	tileArray[cordinates[0]][cordinates[1]][cordinates[2]][cordinates[3]].set_piece(ppiece)

func get_tile(w, x, y, z):
	if (x > 2 or y > 2 or z > 2 or w > 2):
		return
	return tileArray[w][x][y][z]
	
func set_firstclick(ptilearea):
	var tile = ptilearea.get_child(0)
	firstclick = tile
	firstclickused = true
	firstclickpiece = tile.get_piece()
	
func set_secondclick(ptilearea):
	var tile = ptilearea.get_child(0)
	secondclick = tile
	secondclickused = true
	
func reset_clicks():
	firstclick = null
	secondclick = null
	firstclickused = false
	secondclickused = false
	firstclickpiece = null
	unhilight()
	
func unhilight():
	for w in range(3):
		for x in range(3):
			for y in range(3):
				for z in range(3):
					tileArray[w][x][y][z].unhilight()
	
func hilighttiles():
	for w in range(3):
		for x in range(3):
			for y in range(3):
				for z in range(3):
					var tile_to_check = tileArray[w][x][y][z]
					if firstclickpiece.get_type() == 'pawn':
						if (firstclickpiece.moveValid(firstclick, tile_to_check) or firstclickpiece.attackValid(tile_to_check)):
							tile_to_check.hilight()
					elif firstclickpiece.get_type() == 'rook':
						if (firstclickpiece.moveValid(firstclick, tile_to_check)):
							tile_to_check.hilight()
					elif firstclickpiece.get_type() == 'king':
						if (firstclickpiece.moveValid(firstclick, tile_to_check)):
							tile_to_check.hilight()
					elif firstclickpiece.get_type() == 'bishop':
						if (firstclickpiece.moveValid(firstclick, tile_to_check)):
							tile_to_check.hilight()
					elif firstclickpiece.get_type() == 'knight':
						if (firstclickpiece.moveValid(firstclick, tile_to_check)):
							tile_to_check.hilight()
					elif firstclickpiece.get_type() == 'queen':
						if (firstclickpiece.moveValid(firstclick, tile_to_check)):
							tile_to_check.hilight()

func handle_click(ptilearea):
	if(gameOver):
		return
	if (blackturn):
		if (!firstclickused):
			if (ptilearea.get_child(0).get_piece().get_type() != 'none'): 
				if (ptilearea.get_child(0).get_piece().get_side() == 'b'):
					set_firstclick(ptilearea)
					hilighttiles()
		elif (!secondclickused and firstclickpiece.get_side() == 'b'):
			set_secondclick(ptilearea)
			if firstclickpiece.move(firstclick, secondclick):
				blackturn = !blackturn
			reset_clicks()
	elif (!blackturn):
		if (!firstclickused):
			if (ptilearea.get_child(0).get_piece().get_type() != 'none'):
				if (ptilearea.get_child(0).get_piece().get_side() == 'w'): 
					set_firstclick(ptilearea)
					hilighttiles()
		elif (!secondclickused and firstclickpiece.get_side() == 'w'):
			set_secondclick(ptilearea)
			if (firstclickpiece.move(firstclick, secondclick)):
				blackturn = !blackturn
			reset_clicks()
	if (kingIsDead() == 'w'):
		print("Black wins!")
	elif (kingIsDead() == 'w'):
		print("White wins!")
		
func kingIsDead():
	var bkingdead = true
	var wkingdead = true
	for w in range(3):
		for x in range(3):
			for y in range(3):
				for z in range(3):
					if (tileArray[w][x][y][z].get_piece().get_type() == 'king'):
						if (tileArray[w][x][y][z].get_piece().get_side() == 'w'):
							wkingdead = false
						elif (tileArray[w][x][y][z].get_piece().get_side() == 'b'):
							bkingdead = false
	if bkingdead:
		gameOver = true
		return 'b'
	elif wkingdead:
		gameOver = true
		return 'w'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
