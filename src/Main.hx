package;

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
		
		var cellSize = 10;
		
		var w = Std.int(Lib.current.stage.stageWidth / cellSize);
		if (w % 2 == 0) w--;
		
		var h = Std.int(Lib.current.stage.stageHeight / cellSize);
		if (h % 2 == 0) h--;
		
		maze = new PrimMaze(w, h, 2, 0, 2);
		
		
		
		
		
		var sh = new Shape();
		for (y in 0...h)
		{
			for (x in 0...w)
			{
				var color = 0x000000;
				var opacity = 1.0;
				switch(maze.cells[x][y].type)
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