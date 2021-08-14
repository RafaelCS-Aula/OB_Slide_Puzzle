package;

import flixel.math.FlxMath;
import flixel.math.FlxRandom;

class Table
{
	public var width:Int;

	public var height:Int;

	public var grid:Array<Array<Bool>>; /* = [for (x in 0...5) [for (y in 0...5) true]];*/

	public function new(boardWidth:Int, boardHeight:Int)
	{
		this.height = FlxMath.absInt(boardHeight);
		this.width = FlxMath.absInt(boardWidth);

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
