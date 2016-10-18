package;

/**
 * ...
 * @author damrem
 */
class Cell
{
	public var x:Int;
	public var y:Int;
	public var type:Int;
	
	public function new(x:Int, y:Int, type:Int)
	{
		this.x = x;
		this.y = y;
		this.type = type;
	}
	
	public function toString():String
	{
		return ""+type;
	}
}