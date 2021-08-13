import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTextField;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxSlider;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	public override function create()
	{
		var titleText = new FlxText(150, 350, 500, "Obidos - Sliding Puzzle", 28);
		var startButton = new FlxButtonPlus(300, 450, OnStartClicked, "Start Game");
		var slider = new FlxSlider(PlayState, "boardSize", 250, 500, 3, 25, 200, 20, 15, 0xFFFFFFFF, 0xFFCC0000);
		slider.decimals = 0;
		slider.nameLabel.text = "Choose the Board Size";
		slider.hoverAlpha = 1;

		add(slider);
		add(titleText);
		add(startButton);
		// startButton.screenCenter;
		super.create();
	}

	public function OnStartClicked()
	{
		FlxG.switchState(new PlayState());
	}
}
