extends Node2D

var pawnclass = preload("pawn.gd")
var tileclass = load("tile.gd")
var tileareaclass = load("TileArea2D.gd")
var tilecollsionclass = load("res://TileCollisionShape2D.gd")
var noneclass = preload("none.gd")
var rookclass = preload('rook.gd')
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
                	var nonepiece = noneclass.new()
                	tileArray[w][x][y][z] = tile.new(w, x, y, z, nonepiece)
                	print(tileArray[w][x][y][z].get_piece())
                	self.add_child(tileAreaArray[w][x][y][z])
                	tileAreaArray[w][x][y][z].add_child(tileArray[w][x][y][z])
                	var rec = RectangleShape2D.new()
                	rec.set_extents(Vector2(50, 50))
                	var collision = CollisionShape2D.new()
                	collision.set_shape(rec)
                	tileAreaArray[w][x][y][z].add_child(collision)
	var wp1 = pawnclass.new(0, 1, 0, 0, 'w')
	var bp1 = pawnclass.new(2, 2, 2, 0, 'b')
	var wr1 = rookclass.new(2, 2, 2, 2, 'w')
	var br1 = rookclass.new(0, 0, 0, 0, 'b')
	place_pieces([wp1, bp1, wr1, br1])
	
func place_pieces(ppieces):
	for piece in ppieces:
		place_piece(piece)

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
	
func handle_click(ptilearea):
	if (!firstclickused):
		if (ptilearea.get_child(0).get_piece().get_type() != 'none'): 
			set_firstclick(ptilearea)
	elif (!secondclickused):
		set_secondclick(ptilearea)
		firstclickpiece.move(firstclick, secondclick)
		reset_clicks()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass