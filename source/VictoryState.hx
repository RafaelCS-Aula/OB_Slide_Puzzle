package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class VictoryState extends FlxState
{
	var fullImage:FlxSprite;

	public function new(pathToImage:String)
	{
		fullImage = new FlxSprite(0, 0);
		fullImage.loadGraphic(pathToImage);
		add(fullImage);
		super();
	}

	public override function create()
	{
		add(new SettingsUI(300, PuzzleImage.boardSize * Tile.TileHeight + 30, 50, PuzzleImage.boardSize * Tile.TileHeight, 430,
			PuzzleImage.boardSize * Tile.TileHeight));

		FlxG.camera.flash(FlxColor.GREEN, 0.3);
		super.create();
	}
}
