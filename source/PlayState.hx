package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.ds.List;
import openfl.display.Tilemap;

class PlayState extends FlxState
{
	var tiles:List<Tile> = new List<Tile>();
	// Board size in tiles
	var boardSize:Int = 4;

	override public function create()
	{
		// Choose an image from the image list
		var imagePaths = [for (path in PuzzleImage.Images.keys()) path];
		var rng = new FlxRandom().int(0, imagePaths.length - 1);
		var choosenPath = imagePaths[rng];
		var imageSize = PuzzleImage.Images[choosenPath];

		// Setup Tile size
		Tile.TileSize = Std.int(imageSize / boardSize);

		// Make the board
		var gameBoard:Table = new Table(boardSize, boardSize);

		// Load the image for the puzzle
		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenPath, true, Tile.TileSize, Tile.TileSize);

		FlxG.plugins.add(new FlxMouseEventManager());
		FlxMouseEventManager.init();

		var emptySquareX:Int = 0;
		var emptySquareY:Int = 0;
		// Create every tile
		for (gX in 0...gameBoard.grid.length)
		{
			for (gY in 0...gameBoard.grid[gX].length)
			{
				if (gameBoard.grid[gY][gX] == false)
				{
					emptySquareX = gY;
					emptySquareY = gX;
					tiles.add(null);
					continue;
				}

				var currentTile:Tile;
				currentTile = new Tile(gY, gX, gameBoard, tileSprite, tiles.length);
				// trace("Added tile at  " + gX + "," + gY);
				tiles.add(currentTile);

				add(currentTile);
			}
		}
		ShuffleTiles(emptySquareX, emptySquareY);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (CheckWin())
		{
			trace("================YOU'VE WON================");
		}
	}

	public function ShuffleTiles(holeX:Int, holeY:Int)
	{
		var xIndexArray:Array<Int> = [for (x in 0...boardSize) x];
		var yIndexArray:Array<Int> = [for (y in 0...boardSize) y];

		var shuffler = new FlxRandom();
		shuffler.shuffle(xIndexArray);
		shuffler.shuffle(yIndexArray);

		var emptyX;
		var emptyY;

		var tileIteratorCount:Int = 0;
		var iteratorOnEmpty:Int = 0;
		var tileArray = [for (t in tiles) t];
		trace("The hole is at:" + holeX + "," + holeY);
		for (x in 0...xIndexArray.length)
		{
			for (y in 0...yIndexArray.length)
			{
				if (xIndexArray[x] == holeX && yIndexArray[y] == holeY)
				{
					continue;
				}
				var iterationTile = tileArray[tileIteratorCount];
				if (iterationTile != null)
				{
					iterationTile.ForceMove(xIndexArray[x], yIndexArray[y]);
				}
				tileIteratorCount++;
			}
		}
	}

	public function CheckWin():Bool
	{
		for (t in tiles)
		{
			if (t == null)
			{
				continue;
			}
			if (!t.OnSpot)
			{
				return false;
			}
		}
		return true;
	}
}
