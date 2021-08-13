package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.tile.FlxTileSpecial;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Tile extends FlxSprite
{
	private var board:Table;

	public var boardX(default, null):Int;
	public var boardY(default, null):Int;

	public var OnSpot(default, null):Bool = false;

	private var solutionBoardX:Int;
	private var solutionBoardY:Int;

	public static var TileWidth:Int = 30;
	public static var TileHeight:Int = 30;

	private var moveDirections:Array<FlxVector> = [
		new FlxVector(0, 1),
		new FlxVector(1, 0),
		new FlxVector(0, -1),
		new FlxVector(-1, 0)
	];

	public function new(solutionX:Int, solutionY:Int, board:Table, sprite:FlxSprite = null, imageIndex = 0)
	{
		trace("ne tile coming up!");
		this.boardX = solutionX;
		this.boardY = solutionY;
		solutionBoardX = solutionX;
		solutionBoardY = solutionY;

		super(boardX * TileWidth, boardY * TileHeight);

		trace("Spawning Tile at pos:" + x + "," + y);
		if (sprite == null)
		{
			// makeGraphic(TileSize, TileSize, new FlxRandom().color());

			var gridString = boardX + "," + boardY;
			var indexString = Std.string(imageIndex);
			var text = new FlxText(x, y, TileWidth, indexString);
			super.loadGraphicFromSprite(text);
			// makeGraphic(TileSize, TileSize, new FlxRandom().color());
			// alpha = 1;
		}
		else
		{
			super.loadGraphicFromSprite(sprite);
			animation.add(".", [imageIndex], 1);
			animation.play(".");
		}
		this.board = board;

		FlxMouseEventManager.add(this, TryMove);
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		OnSpot = boardX == solutionBoardX && boardY == solutionBoardY;
	}

	public function TryMove(t:Tile)
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

		for (t in 0...moveDirections.length)
		{
			var newX:Int = boardX + Std.int(moveDirections[t].x);
			var newY:Int = boardY + Std.int(moveDirections[t].y);
			try
			{
				if (board.grid[newX][newY] == false)
				{
					openDirection = moveDirections[t];
					trace("Can move in direction: " + moveDirections[t]);
					return openDirection;
				}
			}
			catch (e)
			{
				trace("This direction leads to outside the grid: " + moveDirections[t]);
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

		boardX = newX;
		boardY = newY;

		FlxTween.tween(this, {x: (boardX * TileWidth), y: (boardY * TileHeight)}, 0.08);
		// x = boardX * TileSize;
		// y = boardY * TileSize;

		trace("Moving to: " + newX + "," + newY);
	}

	public function ForceMove(newX:Int, newY:Int)
	{
		// x = newX * TileSize;
		// y = newY * TileSize;

		boardX = newX;
		boardY = newY;
		FlxTween.tween(this, {x: (boardX * TileWidth), y: (boardY * TileHeight)}, 0.1);

		trace("Moving to grid: " + newX + "," + newY);
		trace("Moving to position: " + x + "," + y);
	}
}
