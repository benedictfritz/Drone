package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld;
	import util.Util;
	
	public class Chaser extends Entity
	{	
		private var _speed:Number;
		
		public function Chaser() 
		{
			var img:Image = new Image(new BitmapData(4, 4, true, 0xffffffff));
			graphic = img;
			setHitbox(img.width-3, img.height-3);
			type = "chaser";
		}
		
		public function init(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			_speed = 2;
		}
		
		override public function update():void
		{
			// Assign the collided Bullet Entity to a temporary var.
			var b:Bullet = collide("bullet", x, y) as Bullet;
			
			// In the case of collision, remove the bullet and replace
			// the block with a source
			if (b)
			{
				b.destroy();
				FP.world.remove(this);
				var newSource:Source = FP.world.create(Source, true) as Source;
				newSource.init(x, y);
				//((ParticleWorld)(FP.world)).addSource(newSource);
				return;
			}
			
			// If two chasers hit each other, consolidate them into one new
			// chaser so that shooting into "packs" of chasers doesn't look
			// bad when they emit
			/*
			var c:Chaser = collide("chaser", x, y) as Chaser;
			if (c)
			{
				FP.world.remove(c);
			}
			*/
			
			// recalculate movement direction every time so the blocks move towards the player
			var playerX:Number = ((ParticleWorld)(FP.world)).getPlayerX();
			var playerY:Number = ((ParticleWorld)(FP.world)).getPlayerY();
			
			//treat the player as the origin for finding vectors
			var xPos:Number = x - playerX;
			var yPos:Number = y - playerY;
			
			var length:Number = Util.getLength(xPos, yPos);
			
			if (length < 5) {
				FP.world.recycle(this);
			}
			
			var xVec:Number = xPos / length;
			var yVec:Number = yPos / length;
			
			x -= (xVec * _speed);
			y -= (yVec * _speed);
		}
		
		private function checkTime():void
		{
			
		}
	}

}