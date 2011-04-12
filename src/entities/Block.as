package entities 
{
	import flash.events.KeyboardEvent;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld
	
	public class Block extends Entity
	{
		private var _speed:Number;
		protected var _time:Number;
		
		public function Block() 
		{
			var img:Image = new Image(new BitmapData(4, 4, false, 0x55FF00));
			graphic = img;
			setHitbox(img.width, img.height);
			type = "block";
		}
		
		/*
		public function init(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			_speed = 1;
		}
		*/
		
		override public function update():void
		{	
			_time += FP.elapsed;
		}
	}
}