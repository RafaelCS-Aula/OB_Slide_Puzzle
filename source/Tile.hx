package;

import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.util.FlxColor;

class Tile extends FlxSprite
{
	private var board:Table;

	private var boardX:Int;
	private var boardY:Int;

	private var solutionBoardX:Int;
	private var solutionBoardY:Int;

	public static var TileSize:Int = 30;

	private var moveDirections:Array<FlxVector> = [
		new FlxVector(0, 1),
		new FlxVector(1, 0),
		new FlxVector(0, -1),
		new FlxVector(-1, 0)
	];

	public function new(boardX:Int, boardY:Int, board:Table, solutionX:Int, solutionY:Int, sprite:FlxSprite = null)
	{
		trace("ne tile coming up!");
		this.boardX = boardX;
		this.boardY = boardY;
		solutionBoardX = solutionX;
		solutionBoardY = solutionY;

		super(boardX * TileSize, boardY * TileSize);
		if (sprite == null)
		{
			// makeGraphic(TileSize, TileSize, new FlxRandom().color());

			makeGraphic(300, 300, FlxColor.BLUE);
			alpha = 1;
		}
		else
		{
			super.loadGraphicFromSprite(sprite);
		}
		this.board = board;
	}

	public function TryMove()
	{
		var movement = GetOpenDirection();
		if (movement != null)
		{
			Move(movement);
		}
		else
		{
			trace("Nowhere for tile to slide to");
			return;
		}
	}

	private function GetOpenDirection():FlxVector
	{
		var openDirection:FlxVector = null;

		for (t in 0...moveDirections.length - 1)
		{
			var newX:Int = boardX + Std.int(moveDirections[t].x);
			var newY:Int = boardY + Std.int(moveDirections[t].y);
			try
			{
				if (board.grid[newX][newY] == false)
				{
					openDirection = moveDirections[t];
				}
			}
			catch (e)
			{
				continue;
			}
		}

		return openDirection;
	}

	private function Move(movement:FlxVector)
	{
		var newX:Int = boardX + Std.int(movement.x);
		var newY:Int = boardY + Std.int(movement.y);

		board.grid[boardX][boardY] = false;
		board.grid[newX][newY] = true;

		super.x = boardX * TileSize;
		super.y = boardY * TileSize;

		boardX = newX;
		boardY = newY;
	}
}
