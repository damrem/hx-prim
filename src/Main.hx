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
	inline static var CELL_SIZE:Float = 10;

	public function new() 
	{
		super();
		
		var w = Std.int(Lib.current.stage.stageWidth / CELL_SIZE);
		if (w % 2 == 0) w--;
		//w = 9;
		
		var h = Std.int(Lib.current.stage.stageHeight / CELL_SIZE);
		if (h % 2 == 0) h--;
		//h = 15;
		
		maze = new PrimMaze(w, h, 2, 0, 2);
		
		
		/*var colorGrid = maze.gridColoring(2, 0, 2);
		for (row in colorGrid)
		{
			trace(row);
		}*/
		
		var sh = new Shape();
		var colors = [0xff0000, 0x00ff00, 0x0000ff, 0xffff00, 0xff00ff, 0x00ffff, 0xff8000, 0xff0080, 0x80ff00, 0x8000ff, 0x00ff80, 0x0080ff];
		for (y in 0... maze.cells.length)
		{
			trace(maze.cells[y]);
			for (x in 0... maze.cells[y].length)
			{
				sh.graphics.beginFill(colors[maze.cells[y][x].type]);
				sh.graphics.drawRect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
			}
		}
		sh.graphics.endFill();
		
		addChild(sh);
		
	}
	
	
	
	

}
