package entities
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld;
	
	public class Source extends Entity 
	{
		private var _bmp:BitmapData;
		private var _emitter:Emitter;
		private var _playing:Boolean;
		private var _image:Image;
		
		// Array and index variable for the voice timings
		private var _voiceArr:Array;
		private var _currVoice:Number = 0;
		
		// Array and index variable for the silence timings
		private var _silenceArr:Array;
		private var _currSilence:Number = 0;
		
		private var _timings:Array;
		// _currTiming will track the current sequence that the game
		// will play, advancing each time the sequence begins
		private var _currTiming:Number;
		
		// _active will store whether or not the sequence is in progress
		private var _active:Boolean;
		
		// rather than mess around with arrays, just keep a boolean if it's
		// the "now i see" portion
		private var _singing:Boolean;
		private var _voiceOffset:Number;
		
		private static var _waitingSource:Array;
		private static var _activeSource:Array;
		// need to track the number of sources at the start of NIS (Now I See)
		// so that we can make all of them active
		
		public function Source()
		{
			// _timings holds all the timings of when the repeated voice/drone
			// pattern happens
			_timings = new Array(15000, 33000, 73000, 92000, 141000);
			_currTiming = 0;
			
			// the _voiceArr will hold the offsets from the _timings array
			// when Noah sings and the song should react
			_voiceArr = new Array(200, 900, 1600, 9250, 9999999);
			_silenceArr = new Array(3200, 11150);
			
			// keep voice offset for the "now I see"
			_voiceOffset = 200;
			
			_image = new Image(new BitmapData(4, 4, false, 0xFF0000));
			var color:uint = randColor();
			type = "source";
			setHitbox(4, 4);
			
			_bmp = new BitmapData(5, 5, false, color);
			_emitter = new Emitter(_bmp);
			_emitter.newType("1", [0]);
			//_emitter.setMotion("1", 0, 100, 0, 360, 40, 0.4);
			_emitter.setMotion("1", 0, 100, 0, 360, 40, 0.2);
			//_emitter.setAlpha("1", 1, 0);
			graphic = _image;
			
			_playing = false;
			_active = false;
			
			// ai caramba, not sure if this will work.
			// we need to instantiate the static arrays somehow
			_waitingSource = new Array();
			_activeSource = new Array();
			
			// every new source is added to the waiting sources
			_waitingSource.push(this);
		}
		
		public function init(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}

		override public function update():void
		{	
			var s:Source = collide("source", x, y) as Source;
			if (s)
			{
				FP.world.remove(s);
			}
			
			if (_playing)
			{
				graphic = _emitter;
				for (var i:int = 0; i < 25; ++i)
				{
					_emitter.emit("1", 0, 0);
				}
				//FP.world.recycle(this);
			}
			else
			{
				graphic = _image;
			}
			
			checkTime();
		}
		
		private function checkTime():void
		{
			var songProg:Number = ParticleWorld.channel.position;
			if(!_active) {
				if (songProg > _timings[_currTiming]) {
					// Set variables in preparation for the sequence
					_active = true;

					_currVoice = 0;
					_currSilence = 0;
				}
			}
			else {
				if (songProg > _timings[_currTiming] + _voiceArr[_currVoice]) {
					var _numSources:Number = _waitingSource.length;
					
					// Using my algebraic phatness I've devised this formula for
					// how many sources we pull from the _waitingSources array
					// ex: first time we pull _numSources / 0+3 aka one third
					//     second time we pull _numSources / -1+3 aka one half
					//     third time we pull _numSources / -2+3 aka all remaining
					var _max:Number = _numSources / ( -(_currVoice) + 3);
					trace(_max);
					
					for (var i:Number = 0; i < _max; i++) {
						var temp:Source = _waitingSource.pop();
						temp.play();
						_activeSource.push(temp);
					}
					
					_currVoice++;
				}
				else if (songProg > _timings[_currTiming] + _silenceArr[_currSilence]) {
					var numActive:Number = _activeSource.length;
					for (var z:Number = 0; z < numActive; z++) {
						var stop:Source = _activeSource.pop();
						stop.stop();
						world.recycle(stop);
					}
					
					_currSilence++;
				}
			}
		}
		
		private function randColor():uint
		{
			var color:uint;
			
			switch(FP.rand(5)) {
				case 0:
					color = 0xEFD279;
					break;
				case 1:
					color = 0x95CBE9;
					break;
				case 2:
					color = 0x024769;
					break;
				case 3:
					color = 0xAFD775;
					break;
				case 4:
					color = 0x2C5700;
					break;
			}
			return color;
		}
		
		public function play():void
		{
			_playing = true;
		}
		
		public function stop():void
		{
			_playing = false;
		}
	}

}