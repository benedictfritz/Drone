package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Reticle extends Entity
	{
		[Embed(source = '../../assets/reticle.png')]
		private const RETICLE:Class;
		
		private var sprReticle:Spritemap = new Spritemap(RETICLE, 64, 64);
		private var shootTime:Number;
		
		public function Reticle()
		{
			sprReticle.add("default", [0], 1, true);
			sprReticle.add("shoot", [1], 1, false);
			
			shootTime = 0;
			
			graphic = sprReticle;
		}
		
		override public function update():void
		{
			this.x = Input.mouseX - 32;
			this.y = Input.mouseY - 32;
			
			if (Input.mouseDown)
				sprReticle.play("shoot");
			else
				sprReticle.play("default");
		}
	}

}