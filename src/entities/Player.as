package entities
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{	
		public function Player() 
		{
			var _circle:Image = Image.createCircle(5, 0xFFFFFF);
			graphic = _circle;
		}
		
		public function init(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			if (Input.check(Key.D))
			{
				x += 100 * FP.elapsed;
			}
			if (Input.check(Key.A))
			{
				x -= 100 * FP.elapsed;
			}
			if (Input.check(Key.W))
			{
				y -= 100 * FP.elapsed;
			}
			if (Input.check(Key.S))
			{
				y += 100 * FP.elapsed;
			}
			
			if (Input.mousePressed)
			{
				var bullet:Bullet = FP.world.create(Bullet, true) as Bullet;
				
				//treat the player as the origin for finding vectors
				var xPos:Number = Input.mouseX - x;
				var yPos:Number = Input.mouseY - y;
				
				var xDis:Number = Math.abs(xPos);
				var yDis:Number = Math.abs(yPos);
				var length:Number = Math.abs(Math.sqrt(Math.pow(xDis, 2) + Math.pow(yDis, 2)));
				
				var xVec:Number = xPos / length;
				var yVec:Number = yPos / length;
				bullet.init(x, y, xVec, yVec);
			}
		}
		
		public function getX():Number
		{
			return x;
		}
		
		public function getY():Number
		{
			return y;
		}
	}
}