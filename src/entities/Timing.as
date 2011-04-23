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
		
		// This is probably how I should have done all the other timing arrays
		// Oh well.
		private var sineTimings:Array;
		
		private var time:Number;
		
		public function Timing() 
		{
			// bridge 1 after 44300
			// bridge 2 after 104250
			playAll = new Array(16600, 24250, 34750, 44300, 74750, 84250, 94750, 104250, 142280, 152400);
			currAll = 0;
			
			playHalf = new Array(15900, 34200, 74200, 94250);
			currHalf = 0;
			
			playThird = new Array(15200, 33250, 73350, 93500, 142130);
			currThird = 0;
			
			// bridge 1 after 46200
			// bridge 2 after 106200
			stopAll = new Array(18200, 26150, 38100, 46200, 78250, 86300, 98250, 106200, 146200, 154200);
			currStop = 0;
			
			swarmTimings = new Array(500, 8000, 18200, 26150, 38100, 46200, 78250, 86300, 98250, 106200, 146200, 154200);
			currSwarm = 0;
			
			streamTimings = new Array(112000);
			currStream = 0;
			
			sineTimings = new Array();
			sineTimings[0] = [58500, 999999999];
			sineTimings[1] = [26500, 46500, 86500, 106500, 141500, 999999999];
			sineTimings[2] = [18200, 39000, 78250, 98500, 135000, 146500, 999999999];
			sineTimings[3] = [66500, 999999999];
			sineTimings[4] = [54000, 64500, 129000, 999999999];
			sineTimings[5] = [0, 34000, 44500, 75000, 84500, 105000, 129000, 146500, 155400, 999999999];
		}
		
		override public function update():void
		{
			time = ParticleWorld.channel.position;
			
			checkSines();

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
		
		private function checkSines():void
		{
			var numTimings:Number = sineTimings.length;
			for (var i:Number = 0; i < numTimings; i++) {
				if (sineTimings[i][0] < time) {
					trace(String(sineTimings[i][0]));
					switch (i) {
						case 0:
							ParticleWorld(world).setSineAmp(15);
							ParticleWorld(world).setSineFreq(2);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 1:
							ParticleWorld(world).setSineAmp(20);
							ParticleWorld(world).setSineFreq(5);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 2:
							ParticleWorld(world).setSineAmp(25);
							ParticleWorld(world).setSineFreq(15);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 3:
							ParticleWorld(world).setSineAmp(30);
							ParticleWorld(world).setSineFreq(20);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 4:
							ParticleWorld(world).setSineAmp(35);
							ParticleWorld(world).setSineFreq(50);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 5:
							ParticleWorld(world).setSineAmp(40);
							ParticleWorld(world).setSineFreq(60);
							(sineTimings[i] as Array).splice(0, 1);
							break;
					}
				}
				
			}
		}
	}

}