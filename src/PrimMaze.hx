package;
import de.polygonal.ds.Array2;

/**
 * ...
 * @author damrem
 */
class PrimMaze
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var entrance(default, null):Cell;
	public var cells(default, null):Array2<Cell>;
	
	public function new(width:Int, height:Int)
	{
		this.width = width;
		this.height = height;
		generate();
		
	}
	
	public function generate():Array2<Cell>
	{
		cells = new Array2<Cell>(width, height);
		
		var path = [];
		var walls = [];
		
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var type;
				if (x % 2 == 0 && y % 2 == 0) type = 3;//PILLAR
				else if ((x % 2 == 0 && y % 2 == 1)|| (x % 2 == 1 && y % 2 == 0))	type = 2;//CLOSED WALL
				else type = 0;//ROOM
				cells.set(x, y, new Cell(x, y, type));
			}
		}
		
		entrance = null;
		while (entrance == null)
		{
			var cell = cells.get(1+Std.random(width-1), 1+Std.random(height-1));
			if (cell.type == 0)
			{
				entrance = cell;
			}
		}
		path.push(entrance);
		
		walls = walls.concat(getAdjacentCells(cells, entrance, [1, 2]));
		
		while (walls.length > 0)
		{
			var wall = walls[Std.random(walls.length)];
			var adjacentRooms = getAdjacentCells(cells, wall, [0]);
			if (adjacentRooms.length >= 2)
			{
				var adjacentRoomsNotInPath = adjacentRooms.filter(function(room)
				{
					return path.indexOf(room) < 0;
				});
				if (adjacentRoomsNotInPath.length == 1)
				{
					wall.type = 1;
					var unvisitedRoom = adjacentRoomsNotInPath[0];
					path.push(unvisitedRoom);
					walls = walls.concat(getAdjacentCells(cells, unvisitedRoom, [1, 2]));
				}
			}
			walls.splice(walls.indexOf(wall), 1);
		}
		
		return cells;
	}
	
	function getAdjacentCells(maze:Array2<Cell>, cell:Cell, types:Array<Int>):Array<Cell>
	{
		var cells:Array<Cell> = [];
		
		if (cell.y > 0)	cells.push(maze.get(cell.x, cell.y - 1));
		if (cell.x < maze.width - 1)	cells.push(maze.get(cell.x + 1, cell.y));
		if (cell.y < maze.height - 1)	cells.push(maze.get(cell.x, cell.y + 1));
		if (cell.x > 0)	cells.push(maze.get(cell.x - 1, cell.y));
		
		return cells.filter(function(cell)
		{
			return types.indexOf(cell.type)>=0;
		});
	}
	
}