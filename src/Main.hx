package;

import de.polygonal.ds.Array2;
import man.HxPrimMaze;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	var maze:PrimMaze;

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		var cellSize = 10;
		var w = Std.int(Lib.current.stage.stageWidth / cellSize);
		if (w % 2 == 0) w--;
		var h = Std.int(Lib.current.stage.stageHeight / cellSize);
		if (h % 2 == 0) h--;
		//trace(w, h);
		
		maze = new PrimMaze(w, h);
		//maze.generate();
		
		/*maze = new Array2<Cell>(w, h);
		
		var path = [];
		var walls = [];
		
		for (y in 0...h)
		{
			for (x in 0...w)
			{
				var type;
				if (x % 2 == 0 && y % 2 == 0) type = 3;//PILLAR
				else if ((x % 2 == 0 && y % 2 == 1)|| (x % 2 == 1 && y % 2 == 0))	type = 2;//CLOSED WALL
				else type = 0;//ROOM
				maze.set(x, y, new Cell(x, y, type));
			}
		}
		
		var entrance:Cell = null;
		while (entrance == null)
		{
			var cell = maze.get(1+Std.random(w-1), 1+Std.random(h-1));
			if (cell.type == 0)
			{
				entrance = cell;
			}
		}
		path.push(entrance);
		
		walls = walls.concat(getAdjacentCells(entrance, [1, 2]));
		
		while (walls.length > 0)
		{
			var wall = walls[Std.random(walls.length)];
			var adjacentRooms = getAdjacentCells(wall, [0]);
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
					walls = walls.concat(getAdjacentCells(unvisitedRoom, [1, 2]));
				}
			}
			walls.splice(walls.indexOf(wall), 1);
		}*/
		
		
		
		
		var sh = new Shape();
		for (y in 0...h)
		{
			for (x in 0...w)
			{
				var color = 0x000000;
				var opacity = 1.0;
				switch(maze.cells.get(x, y).type)
				{
					case CellType.ROOM: color = 0x000000; opacity = 0;
					case CellType.WALL_OPEN: color = 0xffffff; opacity = 0.1;
					case CellType.WALL_CLOSED: color = 0xffffff; opacity = 0.9;
					case CellType.PILLAR: color = 0xffffff; opacity = 1;
				}
				if (x == maze.entrance.x && y == maze.entrance.y)
				{
					color = 0xffff00;
					opacity = 1;
				}
				sh.graphics.beginFill(color, opacity);
				sh.graphics.drawRect(x * cellSize, y * cellSize, cellSize, cellSize);
			}
			
		}
		sh.graphics.endFill();
		addChild(sh);
		
	}
	
	

}



//enum CellState = {
	//Pillar,
	//Room,
	//Wall
//};