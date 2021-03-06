package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import haxe.ds.List;

class PlayState extends FlxState
{
	var tiles:List<Tile> = new List<Tile>();

	// Board size in tiles
	private var choosenImagePath:String = "";

	private var checkWinTimer:Float = 10;

	override public function create()
	{
		var tileGroup = new FlxTypedGroup();
		// Choose an image from the image list
		var imagePaths = [];
		var imageWidth = 0;
		var imageHeight = 0;
		var choosenPath = "";

		var setBoardSize:Int = PuzzleImage.boardSize;
		setBoardSize = Math.round(setBoardSize);
		trace(setBoardSize);
		if (PuzzleImage.SquareBoard)
		{
			imagePaths = [for (path in PuzzleImage.SquareImages.keys()) path];
			var rng = new FlxRandom().int(0, imagePaths.length - 1);
			choosenPath = imagePaths[rng];
			imageWidth = PuzzleImage.SquareImages[choosenPath][0];
			imageHeight = PuzzleImage.SquareImages[choosenPath][1];
		}
		else
		{
			imagePaths = [for (path in PuzzleImage.Images.keys()) path];
			var rng = new FlxRandom().int(0, imagePaths.length - 1);
			choosenPath = imagePaths[rng];
			imageWidth = PuzzleImage.Images[choosenPath][0];
			imageHeight = PuzzleImage.Images[choosenPath][1];
		}

		choosenImagePath = choosenPath;

		// Setup Tile size
		Tile.TileWidth = Std.int(imageWidth / setBoardSize);
		Tile.TileHeight = Std.int(imageHeight / setBoardSize);

		// Make the board
		var gameBoard:Table = new Table(setBoardSize, setBoardSize);

		// Load the image for the puzzle
		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenImagePath, true, Tile.TileWidth, Tile.TileHeight);

		var emptySquareX:Int = 0;
		var emptySquareY:Int = 0;

		var tileCoords:List<FlxVector> = new List<FlxVector>();
		tiles.clear();
		var setupGrid = gameBoard.grid;
		var imageTileIndex = 0;

		try
		{ // Create every tile
			for (gX in 0...setupGrid.length)
			{
				for (gY in 0...setupGrid[gX].length)
				{
					if (gameBoard.grid[gY][gX] == false)
					{
						emptySquareX = gY;
						emptySquareY = gX;
						imageTileIndex++;
						continue;
					}

					var currentTile:Tile;
					currentTile = new Tile(gY, gX, gameBoard, tileSprite, imageTileIndex);

					imageTileIndex++;
					// trace("Added tile at  " + gX + "," + gY);
					tiles.add(currentTile);
					tileGroup.add(currentTile);
					tileCoords.add(new FlxVector(gY, gX));

					add(currentTile);
				}
			}
		}
		catch (e)
		{
			FlxG.resetState();
		}
		// If it for some reason adds too many tiles reset and try again
		if (tiles.length > (setBoardSize * setBoardSize) - 1)
		{
			while (tiles.length > (setBoardSize * setBoardSize) - 1)
			{
				tiles.remove(tiles.last());
			}
		}

		ShuffleTiles(tileCoords);

		FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

		trace("Empty Square at: " + emptySquareX + "," + emptySquareY);

		add(new SettingsUI(300, setBoardSize * Tile.TileHeight + 30, 50, setBoardSize * Tile.TileHeight, 430, setBoardSize * Tile.TileHeight + 50));
		checkWinTimer = 4;
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		checkWinTimer -= 1 * elapsed;
		// trace(checkWinTimer);
		if (CheckWin() && checkWinTimer < 0)
		{
			trace("================YOU'VE WON================");
			// FlxG.state.destroy();
			FlxG.switchState(new VictoryState(choosenImagePath));
		}
	}

	public function ShuffleTiles(/*holeX:Int, holeY:Int*/ tileCoords:List<FlxVector>)
	{
		/*var xIndexArray:Array<Int> = [for (x in 0...setBoardSize) x];
			var yIndexArray:Array<Int> = [for (y in 0...setBoardSize) y];


			shuffler.shuffle(xIndexArray);
			shuffler.shuffle(yIndexArray); */

		var shuffler = new FlxRandom();
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
