package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld;
	
	public class Chaser extends Entity
	{	
		private var _speed:Number;
		public function Chaser() 
		{
			var img:Image = new Image(new BitmapData(4, 4, true, 0xffffffff));
			graphic = img;
			setHitbox(img.width, img.height);
			type = "block";
		}
		
		public function init(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			_speed = 1;
			
			/*
			var test:Block = new Block();
			test.init(400, 300);
			FP.world.add(test);
			*/
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
				((ParticleWorld)(FP.world)).addSource(newSource);
				return;
			}
			
			// recalculate movement direction every time so the blocks move towards the player
			var playerX:Number = ((ParticleWorld)(FP.world)).getPlayerX();
			var playerY:Number = ((ParticleWorld)(FP.world)).getPlayerY();
			
			//treat the player as the origin for finding vectors
			var xPos:Number = x - playerX;
			var yPos:Number = y - playerY;
			
			var xDis:Number = Math.abs(xPos);
			var yDis:Number = Math.abs(yPos);
			var length:Number = Math.abs(Math.sqrt(Math.pow(xDis, 2) + Math.pow(yDis, 2)));
			
			if (length < 5) {
				FP.world.recycle(this);
			}
			
			var xVec:Number = xPos / length;
			var yVec:Number = yPos / length;
			
			x -= (xVec * _speed);
			y -= (yVec * _speed);
		}
	}

}