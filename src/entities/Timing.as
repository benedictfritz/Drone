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
			// bridge 1 53500 - 66200
			// bridge 2 112400 - 13500
			
			playAll = new Array(16600, 24250, 34750, 44200, 54600, 64000, 74750, 84250, 94750, 104250, 112800, 122000, 142800, 152100, 99999999);
			currAll = 0;
			
			playHalf = new Array(15900, 34200, 53800, 73900, 94000, 112000, 141800, 99999999);
			currHalf = 0;
			
			playThird = new Array(15200, 33250, 53000, 73000, 93200, 141000, 99999999);
			currThird = 0;
			
			
			// bridge 1 after 46200
			// bridge 2 after 106200
			stopAll = new Array(18200, 26150, 38100, 46200, 58400, 66200, 78250, 86300, 98250, 106200, 117000, 128400, 146200, 154200, 99999999);
			currStop = 0;
			
			swarmTimings = new Array(500, 8000, 18200, 26150, 38100, 46200, 58400, 66200, 78250, 86300, 98250, 106200, 117500, 146200, 99999999);
			currSwarm = 0;
			
			streamTimings = new Array(99999999, 99999999);//112000, 128400, 99999999);
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
				
				// getting a bug where not all of the sources are being cleared
				// clear them this way to make sure
				var remainingSources:Vector.<Source> = new Vector.<Source>();
				world.getClass(Source, remainingSources);
				for each (var source:Source in remainingSources) {
					world.remove(source);
				}
			}
		}
		
		private function checkSines():void
		{
			var numTimings:Number = sineTimings.length;
			for (var i:Number = 0; i < numTimings; i++) {
				if (sineTimings[i][0] < time) {
					switch (i) {
						case 0:
							ParticleWorld(world).setSineAmp(5);
							ParticleWorld(world).setSineFreq(50);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 1:
							ParticleWorld(world).setSineAmp(20);
							ParticleWorld(world).setSineFreq(50);
							ParticleWorld(world).setSineSpeed(10);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 2:
							ParticleWorld(world).setSineAmp(25);
							ParticleWorld(world).setSineFreq(50);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 3:
							ParticleWorld(world).setSineAmp(30);
							ParticleWorld(world).setSineFreq(50);
							ParticleWorld(world).setSineSpeed(30);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 4:
							ParticleWorld(world).setSineAmp(35);
							ParticleWorld(world).setSineFreq(50);
							(sineTimings[i] as Array).splice(0, 1);
							break;
						case 5:
							ParticleWorld(world).setSineAmp(50);
							ParticleWorld(world).setSineFreq(60);
							ParticleWorld(world).setSineSpeed(5);
							(sineTimings[i] as Array).splice(0, 1);
							break;
					}
				}
				
			}
		}
	}

}