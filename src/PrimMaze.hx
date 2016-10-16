package;

/**
 * ...
 * @author damrem
 */
class PrimMaze
{
	public var x0(default, null):Int;
	public var x1(default, null):Int;
	public var y1(default, null):Int;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var entrance(default, null):Cell;
	public var cells(default, null):Array<Array<Cell>>;
	
	public function new(width:Int, height:Int, x0:Int, x1:Int, y1:Int)
	{
		this.x0 = x0;
		this.x1 = x1;
		this.y1 = y1;
		this.width = width;
		this.height = height;
		gridColoring();
		generate();
	}
	
	function gridColoring()
	{
		var nbColors = Std.int(Math.abs(x0 * y1));
		if (nbColors < 3) throw "Grid coloring must have at least 3 colors";
		
		
	}
	
	public function generate():Array<Array<Cell>>
	{
		cells = [for (i in 0...width)[]];
		
		var path = [];
		var walls = [];
		
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var type:Int;
				if (x % 2 == 0 && y % 2 == 0) type = CellType.PILLAR;//PILLAR
				else if ((x % 2 == 0 && y % 2 == 1)|| (x % 2 == 1 && y % 2 == 0))	type = CellType.WALL_CLOSED;//CLOSED WALL
				else type = CellType.ROOM;//ROOM
				cells[x][y] = new Cell(x, y, type);
			}
		}
		
		entrance = null;
		while (entrance == null)
		{
			var cell = cells[1 + Std.random(width - 1)][1 + Std.random(height - 1)];
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
		
		if (cell.y > 0)	cells.push(maze[cell.x][cell.y - 1]);
		if (cell.x < width - 1)	cells.push(maze[cell.x + 1][cell.y]);
		if (cell.y < height - 1)	cells.push(maze[cell.x][cell.y + 1]);
		if (cell.x > 0)	cells.push(maze[cell.x - 1][cell.y]);
		
		return cells.filter(function(cell)
		{
			return types.indexOf(cell.type)>=0;
		});
	}
	
}