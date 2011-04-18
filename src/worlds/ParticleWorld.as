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
		
		public static var time:Number = 0;
		private var currVoice:Number = 0;
		private var _currSilence:Number = 0;
		
		private var _voiceArr:Array;
		private var _silenceArr:Array;
		
		private var timerdisplay:TimeDisplay;
		private var _player:Player;
		
		private var _waitingSource:Array;
		private var _activeSource:Array;
		
		private var _sineWave:Sinewave;
		
		private var _swarm:Swarm;
		
		public function ParticleWorld() 
		{	
			_player = new Player();
			_player.init(400, 300);
			add(_player);
			
			_waitingSource = new Array();
			_activeSource = new Array();
			
			_sineWave = new Sinewave();
			add(_sineWave);
		}
		
		override public function begin():void
		{	
			_swarm = new Swarm();
			add(_swarm);
			_swarm.init();
			
			_sineWave.init();
			
			timerdisplay = new TimeDisplay(time);
			add(timerdisplay);
			
			currVoice = 0;
			
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
		
		public function addSource(src:Source):void
		{
			_waitingSource.push(src);
		}
	}
}