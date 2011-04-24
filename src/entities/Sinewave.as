package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	import worlds.ParticleWorld;
	
	public class Sinewave extends Entity
	{	
		private var _time:Number;
		private var _blocks:Array;
		
		private var amplitude:Number;
		private var angularFreq:Number;
		private var speed:Number;
		private var yOffset:Number
		
		public function Sinewave(y:Number, amp:Number, freq:Number, speed:Number) 
		{
			_blocks = new Array();
			_time = 0;
			
			amplitude = amp;
			angularFreq = freq;
			this.speed = speed;
			yOffset = y;
			
			for (var i:Number = 0; i < FP.width; i+=8)
			{
				var newBlock:Block = new Block();
				newBlock.init(i, (Math.sin(_time * angularFreq) * amplitude) + yOffset);
				_blocks.push(newBlock);
			}
		}
		
		public function init():void
		{
			for each(var block:Block in _blocks) {
				world.add(block);
			}
		}
		
		override public function update():void
		{
			_time += FP.elapsed;
			
			for (var i:Number = 0; i < _blocks.length; i++)
			{
				((Block)(_blocks[i])).y = (-amplitude * Math.sin(_time * angularFreq + i * .05 * speed)) + yOffset;
			}
		}
		
		public function setAmp(amp:Number):void
		{
			amplitude = amp;
		}
		
		public function setFreq(freq:Number):void
		{
			angularFreq = freq;
		}
		
		public function setSpeed(speed:Number):void
		{
			this.speed = speed;
		}
	}

}