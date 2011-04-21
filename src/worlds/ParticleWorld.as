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
		
		private var timerdisplay:TimeDisplay;
		private var _player:Player;
		
		private var _waitingSource:Array;
		private var _activeSource:Array;
		
		private var _sineWave:Sinewave;
		
		private var _swarmArray:Array;
		private var _swarmTimings:Array;
		private var _currSwarm:Number;
		
		private var _timing:Timing;
		
		public var time:Number;
		
		public function ParticleWorld() 
		{	
			_swarmArray = new Array();
			
			_timing = new Timing();
			add(_timing);
			
			_player = new Player();
			_player.init(400, 300);
			add(_player);
			
			_waitingSource = new Array();
			_activeSource = new Array();
			
			_sineWave = new Sinewave();
			add(_sineWave);
			
			_currSwarm = 0;
			
			time = 0;
		}
		
		override public function begin():void
		{	
			_sineWave.init();
			
			timerdisplay = new TimeDisplay(time);
			add(timerdisplay);
			
			//_swarmArray.push(_swarm);
			
			var music:Sound = new MUSIC();
			channel = music.play(0, 1);
		}
		
		override public function update():void 
		{	
			time += FP.elapsed;
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
		
		public function getSwarms():Array
		{
			return _swarmArray;
		}
	}
}