extends TileMapLayer

##werdom no touchy pls

var aStar:AStar2D
# get 'size' from tilemap2d to know how big to make aStar grid
var size = self.get_used_rect().size

func _ready() -> void:
	aStar = AStar2D.new() # make an aStar grid
	aStar.reserve_space(size.x * size.y) # sync aStar grid size to tilemap2d size

# go over all existing cells to fill in space aStar has reserved

func getAStarCellID(vCell: Vector2)->int:
	return int(vCell.y+vCell.x*self.get_used_rect().size.y)
	for i in size.x: # for every row of tiles,
		for j in size.y: # go through every coloumn of tiles,
			var idx = getAStarCellID(Vector2(i,j)) # get the tile's aStar id,
			# and add it as a point on the aStar grid.
			aStar.add_point(idx, aStar.map_to_world(Vector2(i,j)))
