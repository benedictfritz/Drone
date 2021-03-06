package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import entities.Chaser;
	
	import worlds.ParticleWorld;

	public class Swarm extends Entity
	{
		protected var blocks:Array;
		
		protected static var _waitingSource:Array = new  Array;
		protected static var _activeSource:Array = new Array;
		
		public function Swarm() 
		{		
			blocks = new Array();
			spawnSwarm();
		}
		
		public function init():void
		{
			for each(var block:Chaser in blocks) {
				world.add(block);
			}
		}
		
		public static function pushWaiting(source:Entity):void {
			_waitingSource.push(source);
		}
		
		public static function removeWaiting(source:Source):void {
			var size:uint = _waitingSource.length;
			for (var i:uint = 0; i < size; i++)
			{
				// compare ids and remove the source with the ID of
				// the source being removed
				if (Source(_waitingSource[i]).getID == source.getID) {
					_waitingSource.splice(i, i);
					break;
				}
			}
		}
		
		private function spawnSwarm():void
		{
			// top and bottom of screen
			for (var x:Number = 0; x < FP.screen.width; x+=10)
			{
				// top
				var topBlock:Chaser = new Chaser();
				topBlock.init(x, -5);
				
				// bottom
				var bottomBlock:Chaser = new Chaser();
				bottomBlock.init(x, FP.screen.height + 5);
				
				blocks.push(topBlock);
				blocks.push(bottomBlock);
			}
			
			for (var y:Number = 0; y < FP.screen.height; y += 10)
			{
				// left
				var leftBlock:Chaser = new Chaser();
				leftBlock.init(-5, y);
				
				// right
				var rightBlock:Chaser = new Chaser();
				rightBlock.init(FP.screen.width + 5, y);
				
				blocks.push(leftBlock);
				blocks.push(rightBlock);
			}
		}
		
		public static function play(denominator:Number):void
		{
			/*
			if (ParticleWorld(world).channel.position > 60000)
				trace("break here");
				*/
			
			// The fraction parameter is the denominator in the fraction
			// of total sources to play. Does that make sense?
			var _max:Number = _waitingSource.length / denominator;
			
			for (var i:Number = 0; i < _max; i++) {
				var temp:Source = _waitingSource.pop();
				// some sources have been removed via collision with
				// other sources but are still in the array
				if (temp == null)
					break;
				Source(temp).play();
				_activeSource.push(temp);
			}
		}
		
		public static function stop():void
		{
			var _numActive:Number = _activeSource.length;
			for (var z:Number = 0; z < _numActive; z++) {
				var temp:Source = _activeSource.pop();
				if(temp != null) {
					temp.stop();
					temp.destroy();
					//world.remove(temp);
				}
			}
			/*
			if(world)
				world.remove(this);
				*/
			//destroy();
		}
		
		public function destroy():void
		{
			world.remove(this);
		}
	}

}