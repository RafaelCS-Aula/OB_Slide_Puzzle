package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxSlider;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import haxe.ds.List;

class PlayState extends FlxState
{
	var tiles:List<Tile> = new List<Tile>();

	// Board size in tiles
	private var choosenImagePath:String;

	private var checkWinTimer:Float = 2;

	override public function create()
	{
		var tileGroup = new FlxTypedGroup();
		// Choose an image from the image list
		var imagePaths;

		if (PuzzleImage.SquareBoard)
			imagePaths = [for (path in PuzzleImage.SquareImages.keys()) path];
		else
			imagePaths = [for (path in PuzzleImage.Images.keys()) path];

		var rng = new FlxRandom().int(0, imagePaths.length - 1);
		var choosenPath = imagePaths[rng];
		var imageWidth = PuzzleImage.Images[choosenPath][0];
		var imageHeight = PuzzleImage.Images[choosenPath][1];

		choosenImagePath = choosenPath;

		// Setup Tile size
		Tile.TileWidth = Std.int(imageWidth / PuzzleImage.boardSize);
		Tile.TileHeight = Std.int(imageHeight / PuzzleImage.boardSize);

		// Make the board
		var gameBoard:Table = new Table(PuzzleImage.boardSize, PuzzleImage.boardSize);

		// Load the image for the puzzle
		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenPath, true, Tile.TileWidth, Tile.TileHeight);

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
				// tileGroup.add(currentTile);
				tileCoords.add(new FlxVector(gY, gX));

				add(currentTile);
			}
		}
		ShuffleTiles(tileCoords);

		FlxG.camera.fade(FlxColor.BLACK, 0.05, true);

		trace("Empty Square at: " + emptySquareX + "," + emptySquareY);

		/*add(new SettingsUI(300, PuzzleImage.boardSize * Tile.TileHeight + 30, 50, PuzzleImage.boardSize * Tile.TileHeight, 430,
			PuzzleImage.boardSize * Tile.TileHeight)); */
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		checkWinTimer -= 1 * elapsed;
		if (CheckWin() && checkWinTimer < 0)
		{
			trace("================YOU'VE WON================");
			// FlxG.state.destroy();
			FlxG.switchState(new VictoryState(choosenImagePath));
		}
	}

	public function ShuffleTiles(/*holeX:Int, holeY:Int*/ tileCoords:List<FlxVector>)
	{
		var xIndexArray:Array<Int> = [for (x in 0...PuzzleImage.boardSize) x];
		var yIndexArray:Array<Int> = [for (y in 0...PuzzleImage.boardSize) y];

		var shuffler = new FlxRandom();
		shuffler.shuffle(xIndexArray);
		shuffler.shuffle(yIndexArray);

		var tileArray = [for (t in tiles) t];
		var tileCoordArray = [for (v in tileCoords) v];
		shuffler.shuffle(tileCoordArray);

		for (t in 0...tileArray.length)
		{
			/*if (tileArray[t] == null)
				continue; */
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
}
