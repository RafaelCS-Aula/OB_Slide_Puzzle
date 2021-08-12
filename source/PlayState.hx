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

	override public function create()
	{
		// Choose an image from the image list
		var imagePaths = [for (path in PuzzleImage.Images.keys()) path];
		var rng = new FlxRandom().int(0, imagePaths.length - 1);
		var choosenPath = imagePaths[rng];
		var imageSize = PuzzleImage.Images[choosenPath];

		// Board size in tiles
		var boardSize:Int = 20;
		// Setup Tile size
		Tile.TileSize = Std.int(imageSize / boardSize);

		// Make the board
		var gameBoard:Table = new Table(boardSize, boardSize);

		// Load the image for the puzzle
		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenPath, true, Tile.TileSize, Tile.TileSize);

		FlxG.plugins.add(new FlxMouseEventManager());
		FlxMouseEventManager.init();
		// Create every tile
		for (gX in 0...gameBoard.grid.length)
		{
			for (gY in 0...gameBoard.grid[gX].length)
			{
				if (gameBoard.grid[gY][gX] == false)
				{
					tiles.add(null);
					continue;
				}

				var currentTile:Tile;
				currentTile = new Tile(gY, gX, gameBoard, gY, gX, tileSprite, tiles.length);
				// trace("Added tile at  " + gX + "," + gY);
				tiles.add(currentTile);

				add(currentTile);
			}
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		/*for (t in 0...tiles.length - 1)
			{
				tiles[t].draw();
		}*/
	}
}
