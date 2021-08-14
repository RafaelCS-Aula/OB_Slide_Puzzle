import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxSlider;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

using flixel.util.FlxSpriteUtil;

class SettingsUI extends FlxTypedGroup<FlxSprite>
{
	var slider:FlxSlider;
	var squareToggleLabel:String = "No";
	var squareToggleText:FlxText;

	public function new(newPuzzleBtnX:Int, newPuzzleBtnY:Int, sizeSliderX:Int, sizeSliderY:Int, useSquareX:Int, useSquareY:Int)
	{
		super();
		var startButton = new FlxButtonPlus(newPuzzleBtnX, newPuzzleBtnY, OnStartClicked, "Start Game");

		var squareButton = new FlxButtonPlus(useSquareX, useSquareY, OnRectangleToggleClicked, "Scale the board to be square?", 200);
		squareToggleText = new FlxText(squareButton.x + 220, useSquareY, 500, squareToggleLabel, 10);

		slider = new FlxSlider(PlayState, "boardSize", sizeSliderX, sizeSliderY, 3, 25, 200, 20, 15, 0xFFFFFFFF, 0xFFCC0000);
		slider.decimals = 0;
		slider.nameLabel.text = "Choose the Board Size";
		slider.hoverAlpha = 1;

		add(startButton);
		add(squareButton);
		add(squareToggleText);
		add(slider);
	}

	public override function update(elapsed:Float)
	{
		squareToggleText.text = squareToggleLabel;
		super.update(elapsed);
	}

	public function OnStartClicked()
	{
		FlxG.switchState(new PlayState());
	}

	public function OnRectangleToggleClicked()
	{
		PlayState.SquareBoard = !PlayState.SquareBoard;

		if (PlayState.SquareBoard)
			squareToggleLabel = "Yes";
		else
			squareToggleLabel = "No";
	}
}
