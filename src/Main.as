package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.*;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import worlds.*;
	import flash.ui.Mouse;
	[SWF(height = '600', width = '800')]
	
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(800, 600);
			FP.screen.scale = 1;
			FP.screen.color = 0x000000;
			//FP.console.enable();
			FP.world = new Menu;
			Mouse.hide();
		}
	}
	
}