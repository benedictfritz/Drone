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
		private var streamTimings:Array;
		private var currStream:uint;
		
		private var time:Number;
		
		public function Timing() 
		{
			/*
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
			playAll[8] = 142280;
			playAll[9] = 152400;
			currAll = 0;
			
			playHalf = new Array();
			playHalf[0] = 15900;
			playHalf[1] = 34200;
			// bridge here
			playHalf[2] = 74200;
			playHalf[3] = 94250;
			//bridge 2 here
			playHalf[4] = 142220;
			currHalf = 0;
			
			playThird = new Array();
			playThird[0] = 15200;
			playThird[1] = 33250;
			// bridge here
			playThird[2] = 73350;
			playThird[3] = 93500;
			//bridge 2 here
			playThird[4] = 142130;
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
			
			swarmTimings = new Array(500, 16600, 24250, 34750, 44300, 74750, 84250, 94750, 104250, 142280, 152400);
			currSwarm = 0;
			
			streamTimings = new Array(112000);
			currStream = 0;
			*/
			
			playAll = new Array();
			// bridge here
			playAll[0] = 74800;
			playAll[1] = 84250;
			playAll[2] = 94750;
			playAll[3] = 104250;
			//bridge 2 here
			playAll[4] = 142280;
			playAll[5] = 152400;
			currAll = 0;
			
			playHalf = new Array();
			// bridge here
			playHalf[0] = 74200;
			playHalf[1] = 94250;
			// bridge 2 here
			playHalf[2] = 142220;
			currHalf = 0;
			
			playThird = new Array();
			// bridge here
			playThird[0] = 73500;
			playThird[1] = 93500;
			//bridge 2 here
			playThird[2] = 142130;
			currThird = 0;
			
			stopAll = new Array();
			// bridge here
			stopAll[0] = 78250;
			stopAll[1] = 86300;
			stopAll[2] = 98250;
			stopAll[3] = 106200;
			//bridge 2 here
			stopAll[4] = 146200;
			stopAll[5] = 154200;
			currStop = 0;
			
			swarmTimings = new Array(7000, 74750, 84250, 94750, 104250, 142280, 152400);
			currSwarm = 0;
			streamTimings = new Array();
			streamTimings[0] = 112000;
			currStream = 0;
		}
		
		override public function update():void
		{
			time = ParticleWorld.channel.position;

			//first, spawn new swarms if it's time
			if ( time > swarmTimings[currSwarm]) {
				ParticleWorld(world).addSwarm();
				currSwarm++;
			}
			if (time > streamTimings[currStream]) {
				ParticleWorld(world).addStream();
				currStream++;
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