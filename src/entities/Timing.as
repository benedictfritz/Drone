package entities 
{
	import net.flashpunk.Entity;
	import worlds.ParticleWorld;
	
	// This class will manage the timing of all events in the game
	// it's an entity so it gets called with update() every spin
	public class Timing extends Entity
	{
		// Make this as simple and inelegant as possible:
		// Have an array for each scale of playing (1/3, 1/2, all)
		// and when they happen
		private var playAll:Array;
		private var currAll:uint;
		private var playHalf:Array;
		private var currHalf:uint;
		private var playThird:Array;
		private var currThird:uint;
		private var stopAll:Array;
		private var currStop:uint;
		
		private var time:Number;
		
		public function Timing() 
		{
			playAll = new Array();
			playAll[0] = 16600;
			currAll = 0;
			
			playHalf = new Array();
			playHalf[0] = 15900;
			currHalf = 0;
			
			playThird = new Array();
			playThird[0] = 15200;
			currThird = 0;
			
			stopAll = new Array();
			stopAll[0] = 18200;
			currStop = 0;
			
			//_swarmTimings = new Array(20000, 40000, 60000, 80000, 100000, 120000, 140000, 160000);
		}
		
		override public function update():void
		{
			time = ParticleWorld.channel.position;
			/*
			if (time > 14000)
				trace("break here!");
				*/
			var swarms:Array = ParticleWorld(world).getSwarms();
			var numSwarms:Number = swarms.length;
			var i:Number = 0;
			
			if (time > playAll[currAll]) {
				for (i = 0; i < numSwarms; i++) {
					Swarm(swarms[i]).play(1);
				}
				currAll++;
			}
			if (time > playHalf[currHalf]) {
				for (i = 0; i < numSwarms; i++) {
					Swarm(swarms[i]).play(2);
				}
				currHalf++;
			}
			if (time > playThird[currThird]) {
				for (i = 0; i < numSwarms; i++) {
					Swarm(swarms[i]).play(3);
				}
				currThird++;
			}
			if (time > stopAll[currStop]) {
				for (i = 0; i < numSwarms; i++) {
					Swarm(swarms[i]).stop();
				}
				currStop++;
			}
		}
	}

}