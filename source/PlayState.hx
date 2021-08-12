package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
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
		var imagePaths = [for (path in PuzzleImage.Images.keys()) path];
		var rng = new FlxRandom().int(0, imagePaths.length - 1);
		var choosenPath = imagePaths[rng];

		// Create the table

		var imageSize = PuzzleImage.Images[choosenPath];

		var boardSize:Int = 10;
		var gameBoard:Table = new Table(boardSize, boardSize);

		Tile.TileSize = Std.int(imageSize / boardSize);

		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(choosenPath, true, Tile.TileSize, Tile.TileSize);

		for (gX in 0...gameBoard.grid.length)
		{
			for (gY in 0...gameBoard.grid[gX].length)
			{
				if (gameBoard.grid[gX][gY] == false)
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
		// Split Image

		// add(tt);

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
