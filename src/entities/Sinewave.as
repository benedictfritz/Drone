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
		private var yOffset:Number
		
		public function Sinewave(y:Number, amp:Number, freq:Number) 
		{
			_blocks = new Array();
			_time = 0;
			
			amplitude = amp;
			angularFreq = freq;
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
				((Block)(_blocks[i])).y = (amplitude * Math.sin(_time * angularFreq + i*.5)) + yOffset;
				//((Block)(_blocks[i])).y = (amplitude * Math.sin(_time * angularFreq)) + yOffset;
			}
		}
		
		public function setAmp(amp:Number):void
		{
			amplitude = amp;
		}
	}

}