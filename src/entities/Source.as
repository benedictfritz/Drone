package entities
{
	import adobe.utils.ProductManager;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld;
	
	public class Source extends Entity 
	{
		// staticly keep track of the number of sources created
		// so each can be assigned a unique ID
		private static var _idCounter:uint = 0;
		private var _id:uint;
		
		private var _bmp:BitmapData;
		private var _emitter:Emitter;
		private var _playing:Boolean;
		private var _image:Image;
		
		public function Source()
		{
			_id = _idCounter;
			_idCounter++;
			
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

			Swarm.pushWaiting(this);
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
				this.collidable = false;
				Swarm.removeWaiting(this);
				world.remove(this);
				return;
			}
			
			if (_playing)
			{
				graphic = _emitter;
				for (var i:int = 0; i < 25; ++i)
				{
					_emitter.emit("1", 0, 0);
				}
			}
			else
			{
				graphic = _image;
			}
		}
			
		private function randColor():uint
		{
			var color:uint;
			
			/*
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
			*/
			
			switch(FP.rand(5)) {
				case 0:
					color = 0xff0000;
					break;
				case 1:
					color = 0xFF7300;
					break;
				case 2:
					color = 0x0051FF;
					break;
				case 3:
					color = 0x00FF00;
					break;
				case 4:
					color = 0xB700FF;
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
		
		public function getID():uint
		{
			return _id;
		}
		
		public function destroy():void
		{
			if(world)
				world.remove(this);
		}
	}

}