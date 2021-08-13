package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxSlider;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import haxe.ds.List;

class PlayState extends FlxState
{
	var tiles:List<Tile> = new List<Tile>();

	// Board size in tiles
	public static var boardSize:Int = 4;

	public static var SquareBoard:Bool = false;

	override public function create()
	{
		// Choose an image from the image list
		var imagePaths;

		if (SquareBoard)
			imagePaths = [for (path in PuzzleImage.SquareImages.keys()) path];
		else
			imagePaths = [for (path in PuzzleImage.Images.keys()) path];

		var rng = new FlxRandom().int(0, imagePaths.length - 1);
		var choosenPath = imagePaths[rng];
		var imageWidth = PuzzleImage.Images[choosenPath][0];
		var imageHeight = PuzzleImage.Images[choosenPath][1];

		// Setup Tile size
		Tile.TileWidth = Std.int(imageWidth / boardSize);
		Tile.TileHeight = Std.int(imageHeight / boardSize);

		// Make the board
		var gameBoard:Table = new Table(boardSize, boardSize);

		// Load the image for the puzzle
		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenPath, true, Tile.TileWidth, Tile.TileHeight);

		FlxG.plugins.add(new FlxMouseEventManager());
		FlxMouseEventManager.init();

		var emptySquareX:Int = 0;
		var emptySquareY:Int = 0;

		var tileCoords:List<FlxVector> = new List<FlxVector>();
		// Create every tile
		for (gX in 0...gameBoard.grid.length)
		{
			for (gY in 0...gameBoard.grid[gX].length)
			{
				if (gameBoard.grid[gY][gX] == false)
				{
					emptySquareX = gY;
					emptySquareY = gX;
					// tiles.add(null);
					continue;
				}

				var currentTile:Tile;
				currentTile = new Tile(gY, gX, gameBoard, tileSprite, tiles.length);

				// trace("Added tile at  " + gX + "," + gY);
				tiles.add(currentTile);
				tileCoords.add(new FlxVector(gY, gX));

				add(currentTile);
			}
		}
		ShuffleTiles(tileCoords);
		var slider = new FlxSlider(PlayState, "boardSize", 50, boardSize * Tile.TileHeight + 30, 3, 25, 200, 20, 15, 0xFFFFFFFF, 0xFFCC0000);
		slider.decimals = 0;
		slider.nameLabel.text = "Choose the Board Size";
		slider.hoverAlpha = 1;

		var restart = new FlxButtonPlus(300, slider.y, OnRestartClicked, "New Puzzle", 120, 30);

		add(restart);
		add(slider);
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

	public function ShuffleTiles(/*holeX:Int, holeY:Int*/ tileCoords:List<FlxVector>)
	{
		var xIndexArray:Array<Int> = [for (x in 0...boardSize) x];
		var yIndexArray:Array<Int> = [for (y in 0...boardSize) y];

		var shuffler = new FlxRandom();
		shuffler.shuffle(xIndexArray);
		shuffler.shuffle(yIndexArray);

		var tileArray = [for (t in tiles) t];
		var tileCoordArray = [for (v in tileCoords) v];
		shuffler.shuffle(tileCoordArray);

		for (t in 0...tileArray.length)
		{
			if (tileArray[t] == null)
				continue;
			tileArray[t].ForceMove(Std.int(tileCoordArray[t].x), Std.int(tileCoordArray[t].y));
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

	public function OnRestartClicked()
	{
		FlxG.resetState();
	}
}
