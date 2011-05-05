package worlds
{
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.geom.Point;
	
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.*;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	import entities.*;
	
	public class ParticleWorld extends World
	{	
		[Embed(source = '/../assets/mysounds.swf#drone')]
		private const MUSIC:Class;
		public static var channel:SoundChannel;
		
		private var _player:Player;
		
		private var _waitingSource:Array;
		private var _activeSource:Array;
		
		private var _topSineWave:Sinewave;
		private var _bottomSineWave:Sinewave;
		
		private var _swarmArray:Array;
		private var _swarmTimings:Array;
		private var _currSwarm:Number;
		private var _timing:Timing;
		private var _eye:Eye;
		public var time:Number;
		private var reticle:Reticle;
		private var once:Boolean;
		
		public function ParticleWorld() 
		{	
			once = true;
			_eye = new Eye();
			add(_eye);
			
			reticle = new Reticle();
			add(reticle);
			
			_swarmArray = new Array();
			
			_timing = new Timing();
			add(_timing);
			
			_player = new Player();
			_player.init(400, 300);
			add(_player);
			
			_waitingSource = new Array();
			_activeSource = new Array();
			
			_topSineWave = new Sinewave(50, 50, 40, 20);
			_bottomSineWave = new Sinewave(550, 5, 30, 20);
			add(_topSineWave);
			add(_bottomSineWave);
			
			_currSwarm = 0;
			
			time = 0;
		}
		
		override public function begin():void
		{	
			_topSineWave.init();
			_bottomSineWave.init();
			
			var music:Sound = new MUSIC();
			channel = music.play(0, 1);
		}
		
		override public function update():void
		{	
			time = channel.position;
			// Grand finale code
			if (time > 154200)
			{
				// stupid boolean to keep track of just executing this code
				// once when we initialize the sequence
				if (once) {
					this.remove(reticle);
					this.remove(_player);
					_eye.add();
					once = false;
				}
				_topSineWave.increaseAmp();
				_bottomSineWave.increaseAmp();
				_topSineWave.changeYoffset(.1);
				_bottomSineWave.changeYoffset(-.1);
			}
			
			if (time > 233900)
				FP.world = new End();
				
			if (Input.pressed(Key.SPACE))
				trace(String(time));
			
			super.update();
		}
		
		public function getPlayerX():Number 
		{
			return _player.getX();
		}
		
		public function getPlayerY():Number
		{
			return _player.getY();
		}
		
		public function addSwarm():void
		{
			var newSwarm:Swarm = new Swarm();
			add(newSwarm);
			newSwarm.init();
			_swarmArray.push(newSwarm);
		}
		
		public function addStream():void
		{
			var newStream:Stream = new Stream();
			add(newStream);
			newStream.init();
			_swarmArray.push(newStream);
		}
		
		public function addCloud():void
		{
			var newCloud:Cloud = new Cloud();
			add(newCloud);
			newCloud.init();
			_swarmArray.push(newCloud);
		}
		
		public function getSwarms():Array
		{
			return _swarmArray;
		}
		
		public function setSineAmp(amp:Number):void
		{
			_topSineWave.setAmp(amp);
			_bottomSineWave.setAmp(amp);
		}
		
		public function setSineFreq(freq:Number):void
		{
			_topSineWave.setFreq(freq);
			_bottomSineWave.setFreq(freq);
		}
		
		public function setSineSpeed(speed:Number):void
		{
			_topSineWave.setSpeed(speed);
			_bottomSineWave.setSpeed(speed);
		}
	}
}