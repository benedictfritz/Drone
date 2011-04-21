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
			playAll[1] = 24250;
			playAll[2] = 34750;
			playAll[3] = 44300;
			// bridge here
			playAll[4] = 74750;
			playAll[5] = 84250;
			playAll[6] = 94750;
			playAll[7] = 104250;
			//bridge 2 here
			playAll[8] = 142750;
			playAll[9] = 152400;
			currAll = 0;
			
			playHalf = new Array();
			playHalf[0] = 15900;
			playHalf[1] = 34200;
			// bridge here
			playHalf[2] = 74200;
			playHalf[3] = 94250;
			//bridge 2 here
			playHalf[4] = 142100;
			currHalf = 0;
			
			playThird = new Array();
			playThird[0] = 15200;
			playThird[1] = 33250;
			// bridge here
			playThird[2] = 73350;
			playThird[3] = 93500;
			//bridge 2 here
			playThird[4] = 141200;
			currThird = 0;
			
			stopAll = new Array();
			stopAll[0] = 18200;
			stopAll[1] = 26150;
			stopAll[2] = 38100;
			stopAll[3] = 46200;
			// bridge here
			stopAll[4] = 78250;
			stopAll[5] = 86300;
			stopAll[6] = 98250;
			stopAll[7] = 106200;
			//bridge 2 here
			stopAll[8] = 146200;
			stopAll[9] = 154200;
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