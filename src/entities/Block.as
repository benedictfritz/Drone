package entities 
{
	import flash.events.KeyboardEvent;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	import worlds.*;
	
	public class Block extends Chaser
	{
		private var _speed:Number;
		private var countdown:Number;
		
		public function Block() 
		{
			var img:Image = new Image(new BitmapData(4, 4, false, 0xFFFFFF));
			graphic = img;
			setHitbox(img.width, img.height);
			type = "block";
			
			countdown = 0;
		}

		override public function update():void
		{	
			var newSource:Source = checkBulletCollision();
			
			if (newSource) {
				graphic.visible = false;
				newSource.play();
				Menu(world).add(new TransitionOut());
				//countdown = 0.5;
			}
			/*
			if (countdown != 0) {
				countdown -= FP.elapsed;
				if (countdown < 0.1)
					FP.world = new ParticleWorld();
			}
			*/
		}
	}
}