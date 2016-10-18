package;

/**
 * ...
 * @author damrem
 */
class PrimMaze
{
	//public var x0(default, null):Int;
	//public var x1(default, null):Int;
	//public var y1(default, null):Int;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var entrance(default, null):Cell;
	public var cells(default, null):Array<Array<Cell>>;
	
	public var colorToCellTypeStrategy:Int->Int;
	
	
	
	public function new(width:Int, height:Int, x0:Int, x1:Int, y1:Int, ?colorToCellTypeStrategy:Int->Int)
	{
		//this.x0 = x0;
		//this.x1 = x1;
		//this.y1 = y1;
		this.width = width;
		this.height = height;
		
		if (colorToCellTypeStrategy == null)
		{
			colorToCellTypeStrategy = function(color:Int):Int
			{
				switch(color)
				{
					case 0: return CellType.PILLAR;
					case 1: return CellType.WALL_CLOSED;
					case 2: return CellType.WALL_CLOSED;
					case 3: return CellType.ROOM;
				}
				return -1;
				
			}
		}
		this.colorToCellTypeStrategy = colorToCellTypeStrategy;
		
		gridColoring(x0, x1, y1);
		generate(x0, x1, y1);
		
		
	}
	
	
	
	public function gridColoring(x0:Int, x1:Int, y1:Int):Array<Array<Int>>
	{
		
		var grid:Array<Array<Int>> = [];
		
		var m = x0 * y1;
		var	n = x0;
		
		var firstOfItsKind = 0;
		
		for (y in 0...height)
		{
			grid[y] = [];
			for (x in 0...width)
			{
				if (x < x0 && y < y1)
				{
					grid[y][x] = firstOfItsKind;
					firstOfItsKind++;
				}
				else if (x >= x0 && y < y1)
				{
					grid[y][x] = grid[y][x - x0];
				}
				else if (x < x1 && y >= y1)
				{
					grid[y][x] = grid[y - y1][x + x0 - x1];
				}
				else if (x>=x1&&y>=y1)
				{
					grid[y][x] = grid[y - y1][x - x1];
				}
			}
		}
		
		return grid;
	}
	
	
	
	public function generate(x0:Int, x1:Int, y1:Int):Array<Array<Cell>>
	{
		cells = [for (i in 0...width)[]];
		
		var colorGrid = gridColoring(x0, x1, y1);
		
		for (y in 0... colorGrid.length)
		{
			var row = colorGrid[y];
			for (x in 0... row.length)
			{
				cells[y][x] = new Cell(x, y, colorToCellTypeStrategy(row[x]));
			}
			trace(row);
		}
	
		
		
		var path = [];
		var walls = [];
		
		entrance = null;
		while (entrance == null)
		{
			var cell = cells[1 + Std.random(height - 1)][1 + Std.random(width - 1)];
			if (cell.type == CellType.ROOM)
			{
				entrance = cell;
			}
		}
		path.push(entrance);
		
		walls = walls.concat(getAdjacentCells(cells, entrance, [CellType.WALL_OPEN, CellType.WALL_CLOSED]));
		
		while (walls.length > 0)
		{
			var wall = walls[Std.random(walls.length)];
			var adjacentRooms = getAdjacentCells(cells, wall, [CellType.ROOM]);
			if (adjacentRooms.length >= 2)
			{
				var adjacentRoomsNotInPath = adjacentRooms.filter(function(room)
				{
					return path.indexOf(room) < 0;
				});
				if (adjacentRoomsNotInPath.length == 1)
				{
					wall.type = CellType.WALL_OPEN;
					var unvisitedRoom = adjacentRoomsNotInPath[0];
					path.push(unvisitedRoom);
					walls = walls.concat(getAdjacentCells(cells, unvisitedRoom, [CellType.WALL_OPEN, CellType.WALL_CLOSED]));
				}
			}
			walls.splice(walls.indexOf(wall), 1);
		}
		
		return cells;
	}
	
	function getAdjacentCells(maze:Array<Array<Cell>>, cell:Cell, types:Array<Int>):Array<Cell>
	{
		var cells:Array<Cell> = [];
		
		if (cell.y > 0)	cells.push(maze[cell.y - 1][cell.x]);
		if (cell.x < width - 1)	cells.push(maze[cell.y][cell.x + 1]);
		if (cell.y < height - 1)	cells.push(maze[cell.y + 1][cell.x]);
		if (cell.x > 0)	cells.push(maze[cell.y][cell.x - 1]);
		
		return cells.filter(function(cell)
		{
			return types.indexOf(cell.type)>=0;
		});
	}
	
}