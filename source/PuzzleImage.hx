import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.display.IBitmapDrawable;
import openfl.utils.IAssetCache;

class PuzzleImage
{
	public var Path(default, null):String;
	public var Width(default, null):Int;
	public var Height(default, null):Int;

	public function new(path:String, width:Int, height:Int)
	{
		Path = path;
		Width = width;
		Height = height;
	}
}
