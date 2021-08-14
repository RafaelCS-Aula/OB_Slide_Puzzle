package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTextField;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxSlider;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var slider:FlxSlider;
	var squareToggleLabel:String = "No";
	var squareToggleText:FlxText;

	public override function create()
	{
		var titleText = new FlxText(150, 350, 500, "Obidos - Sliding Puzzle", 28);

		add(titleText);
		add(new SettingsUI(300, 450, 250, 500, 250, 600));
		FlxG.plugins.add(new FlxMouseEventManager());
		FlxMouseEventManager.init();
		super.create();
	}
}
