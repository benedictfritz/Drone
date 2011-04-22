package entities 
{

	public class Stream extends Swarm
	{
		import net.flashpunk.FP;
		
		public function Stream() 
		{
			blocks = new Array();
			spawnStream();
		}
		
		private function spawnStream():void
		{
			// there will be four streams spawned
			// one going out diagonally from each corner of the screen
			var x:Number
			
			// top/bottom left
			for (x = 0; x > (0 - FP.width); x-=5)
			{
				// y = -3/4x since we want to create a line that if undisturbed
				// will cross exactly diagonally across the screen giving it a 
				// slope of -3/4.
				var topLeft:Chaser = new Chaser();
				topLeft.init(x, (3 / 4) * x);
				
				var bottomLeft:Chaser = new Chaser();
				bottomLeft.init(x, -(3 / 4) * x + FP.height);
				
				blocks.push(topLeft);
				blocks.push(bottomLeft);
			}
			
			// top/bottom right
			for (x = FP.width; x < FP.width*2; x+=5)
			{
				var bottomRight:Chaser = new Chaser();
				bottomRight.init(x, ( -3 / 4) * x + (0 + FP.height));
				
				var topRight:Chaser = new Chaser();
				topRight.init(x, (3 / 4) * x);//+ (0+FP.height));
				
				blocks.push(topRight);
				blocks.push(bottomRight);
			}
		}
	}
}