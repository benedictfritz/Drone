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
		private var swarmTimings:Array;
		private var currSwarm:uint;
		
		private var time:Number;
		
		public function Timing() 
		{
			playAll = new Array();
			playAll[0] = 16600;
			playAll[1] = 34650;
			currAll = 0;
			
			playHalf = new Array();
			playHalf[0] = 15900;
			playHalf[1] = 33950;
			currHalf = 0;
			
			playThird = new Array();
			playThird[0] = 15200;
			playThird[1] = 33250;
			currThird = 0;
			
			stopAll = new Array();
			stopAll[0] = 18200;
			stopAll[1] = 37050;
			currStop = 0;
			
			swarmTimings = new Array(500, 20000, 40000, 60000, 80000, 100000, 120000, 140000, 160000);
			currSwarm = 0;
		}
		
		override public function update():void
		{
			time = ParticleWorld.channel.position;

			//first, spawn new swarms if it's time
			if ( time > swarmTimings[currSwarm]) {
				ParticleWorld(world).addSwarm();
				currSwarm++;
			}
			
			/*
			if (time > 21000)
				trace("Break here");
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