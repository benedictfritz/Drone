package entities
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	public class Source extends Entity 
	{
		private var _bmp:BitmapData;
		private var _emitter:Emitter;
		private var _playing:Boolean;
		private var _image:Image;
		private var _voiceArr:Array;
		private var _silenceArr:Array;
		
		public function Source()
		{
			_voiceArr = new Array(15200, 15900, 16600, 24250);
			_silenceArr = new Array(18200, 26150);
			
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
		}
		
		private function checkTime():void
		{
			if (ParticleWorld.channel.position > _voiceArr[currVoice]) {
				currVoice++;
				for ( var i:Number = 0; i < (_waitingSource.length / 3); i++ ) 
				{
					var temp:Source = _waitingSource.pop();
					temp.play();
					_activeSource.push(temp);
				}
			}
			
			if (ParticleWorld.channel.position > _silenceArr[_currSilence]) {
				_currSilence++;
				var numActive:Number = _activeSource.length;
				for (var z:Number = 0; z < numActive; z++)
				{
					var stop:Source = _activeSource.pop();
					stop.stop();
				}
				
				for (var j:Number = 0; j < _waitingSource.length; i++)
				{
					_waitingSource.pop();
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