package entities
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	
	public class Source extends Entity 
	{
		private var _bmp:BitmapData;
		private var _emitter:Emitter;
		private var _playing:Boolean;
		
		public function Source()
		{
			var color:uint = randColor();
			
			_bmp = new BitmapData(5, 5, false, color);
			_emitter = new Emitter(_bmp);
			_emitter.newType("1", [0]);
			//_emitter.setMotion("1", 0, 100, 0, 360, 40, 0.4);
			_emitter.setMotion("1", 0, 100, 0, 360, 40, 0.2);
			//_emitter.setAlpha("1", 1, 0);
			graphic = _emitter;
			
			_playing = false;
		}
		
		public function init(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}

		override public function update():void
		{
			/*
			if (_playing)
			{
				if (_emitter.particleCount == 0)
				{
					FP.world.recycle(this);
				}
			}
			*/
			
			if (_playing)
			{
				for (var i:int = 0; i < 25; ++i)
				{
					_emitter.emit("1", 0, 0);
				}
				//FP.world.recycle(this);
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
			/*
			for (var i:int = 0; i < 512; ++i)
			{
				_emitter.emit("1", 0, 0);
			}
			*/
			_playing = true;
		}
		
		public function stop():void
		{
			_playing = false;
		}
	}

}