package entities 
{

	public class Cloud extends Swarm
	{
		import net.flashpunk.FP;
		
		public function Cloud() 
		{
			blocks = new Array();
			spawnCloud();
		}
	
		private function spawnCloud():void
		{
			// the cloud will consist of randomly scattered chasers that
			// will converge on the player
			// a swarm consists of 280 chasers, and that seems to be a good number
			var i:Number
			var x:Number;
			var y:Number;
			var newChaser:Chaser;
			
			/*
			//top
			for (i = 0; i < 40; i++) {
				x = FP.rand(800);
				y = -(FP.rand(600));
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//bottom
			for (i = 0; i < 40; i++) {
				x = FP.rand(800);
				y = 600 + FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//left
			for (i = 0; i < 40; i++) {
				x = -(FP.rand(800));
				y = FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//right
			for (i = 0; i < 40; i++) {
				x = 800 + FP.rand(800);
				y = FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			*/
			
			//top
			for (i = 0; i < 80; i++) {
				x = FP.rand(800);
				y = -(FP.rand(600));
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//bottom
			for (i = 0; i < 80; i++) {
				x = FP.rand(800);
				y = 600 + FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//left
			for (i = 0; i < 60; i++) {
				x = -(FP.rand(800));
				y = FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
			
			//right
			for (i = 0; i < 60; i++) {
				x = 800 + FP.rand(800);
				y = FP.rand(600);
				newChaser = new Chaser();
				newChaser.init(x, y);
				blocks.push(newChaser);
			}
		}
	}
}