import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.display.IBitmapDrawable;
import openfl.utils.IAssetCache;

class PuzzleImage
{
	public static var Images(default, null):haxe.ds.Map<String, Array<Int>> = [
		"assets/images/PuzzleImages/placa7.png" => [647, 647],
		AssetPaths.datas_edificios4__jpg.toString() => [800, 600],
		AssetPaths.entrada_oratorio3__jpg.toString() => [800, 600],
		AssetPaths.entrada_oratorio_teto1__png.toString() => [600, 800],
		AssetPaths.igreja_scm1__png.toString() => [600, 800],
		AssetPaths.muralha5__png.toString() => [600, 800],
		AssetPaths.muralha_moinho2__png.toString() => [600, 800],
		AssetPaths.torre_cerco1__jpg.toString() => [800, 600]
	];
	public static var SquareImages(default, null):haxe.ds.Map<String, Array<Int>> = [
		"assets/images/PuzzleImages/placa7.png" => [647, 647],
		AssetPaths.datas_edificios4_sqr__jpg.toString() => [800, 800],
		AssetPaths.entrada_oratorio3_sqr__jpg.toString() => [800, 800],
		AssetPaths.entrada_oratorio_teto1_sqr__png.toString() => [800, 800],
		AssetPaths.igreja_scm1_sqr__png.toString() => [800, 800],
		AssetPaths.muralha5_sqr__png.toString() => [800, 800],
		AssetPaths.muralha_moinho2_sqr__png.toString() => [800, 800],
		AssetPaths.torre_cerco1_sqr__jpg.toString() => [800, 800]
	];
}
