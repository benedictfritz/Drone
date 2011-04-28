package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Particle;
	import net.flashpunk.utils.Draw;
	import worlds.ParticleWorld;
	
	/*
	 * This class is from Noel Berry's OSPE
	 * http://www.noelberry.ca/
	 * Much love
	 */
	public class TransitionOut extends Entity
	{
		
		public var alpha:Number = 0;			//alpha is used for the rectangle which is drawn over the screen (so that it fades out)
		public var colour:uint = 0x000000;		//color of the rectangle
		
		public function TransitionOut() 
		{
			//set ourselves above everything else
			layer = -1000;
		}
		
		override public function render():void
		{
			//draw the rectangle
			Draw.rect(FP.camera.x, FP.camera.y, FP.width, FP.height, colour, alpha);
			
			//decrease alpha
			alpha += 0.01;
			
			//if the alpha is 0, tell the game to go to the next level
			if (alpha > 1)
			{
				FP.world = new ParticleWorld();
			}
		}
		
	}

}