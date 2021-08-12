package;

import flixel.math.FlxRandom;

class Table
{
	public var width:Int;

	public var heigh:Int;

	public var grid:Array<Array<Bool>>;

	public function new(width, height)
	{
		this.heigh = height;
		this.width = width;

		grid = [for (x in 0...width) [for (y in 0...height) true]];

		// Select a square on the edge of the board
		var rnd:FlxRandom = new FlxRandom();
		var rndX:Int = rnd.int(0, width - 1);
		var rndY:Int = 0;
		if (rndX == 0 || rndX == width - 1)
		{
			rndY = rnd.int(0, height - 1);
		}
		else
		{
			var isZero:Bool = rnd.bool(50);
			if (isZero)
			{
				rndY = 0;
			}
			else
			{
				rndY = height;
			}
		}

		grid[rndX][rndY] = false;
	}
}
