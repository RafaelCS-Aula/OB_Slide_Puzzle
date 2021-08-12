package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.ds.List;
import openfl.display.Tilemap;

class PlayState extends FlxState
{
	var tiles:List<Tile> = new List<Tile>();

	override public function create()
	{
		// Create the table
		var pictureToUse:FlxGraphicAsset = AssetPaths.placa7__png;
		var gameBoard:Table = new Table(10, 10);

		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(pictureToUse, true, Tile.TileSize, Tile.TileSize);

		for (gX in 0...gameBoard.grid.length)
		{
			for (gY in 0...gameBoard.grid[gX].length)
			{
				if (gameBoard.grid[gX][gY] == false)
				{
					continue;
				}

				var currentTile:Tile;
				currentTile = new Tile(gX, gY, gameBoard, gX, gY, tileSprite, tiles.length);
				trace("Added tile at  " + gX + "," + gY);
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
