package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		private var _xdir:Number;
		private var _ydir:Number;
		private var _speed:Number;
		
		public function Bullet() 
		{
			var img:Image = new Image(new BitmapData(4, 4, true, 0xffffffff));
			graphic = img;
			setHitbox(img.width, img.height);
			type = "bullet";
		}
		
		public function init(x:Number, y:Number, xVec:Number, yVec:Number):void
		{
			this.x = x;
			this.y = y;
			_xdir = xVec;
			_ydir = yVec;
			_speed = 5;
		}
		
		override public function update():void
		{
			if (!onCamera)
				FP.world.recycle(this);
				
			this.x += _xdir * _speed;
			this.y += _ydir * _speed;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}
}