package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import openfl.display.Tilemap;

class PlayState extends FlxState
{
	var tiles:Array<Tile>;

	override public function create()
	{
		// Create the table
		var pictureToUse:FlxGraphicAsset = AssetPaths.placa7__png;
		var gameBoard:Table = new Table(10, 10);
		var map = new FlxTilemap();
		map.graphic = pictureToUse;

		var dummySprite:FlxSprite = new FlxSprite(0, 0);
		var tileSprite = dummySprite.loadGraphic(pictureToUse, true, Tile.TileSize, Tile.TileSize);

		for (gX in 0...gameBoard.grid.length - 1)
		{
			for (gY in 0...gameBoard.grid[gX].length - 1)
			{
				var currentSprite = map.tileToSprite(gX, gY);
				var currentTile:Tile;
				currentTile = new Tile(gX, gY, gameBoard, gX, gY);

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
