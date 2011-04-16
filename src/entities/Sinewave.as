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
		
		public function Sinewave() 
		{
			_blocks = new Array();
			_time = 0;
			
			for (var i:Number = 0; i < 800; i+=1)
			{
				var newBlock:Block = new Block();
				var xPos:Number = 0 + i * 4;
				newBlock.init(xPos, (Math.sin(_time * 5) * 10) + 300);
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
				((Block)(_blocks[i])).y = (12 * Math.sin(_time * 20 + (.1 * i)) * 10) + 300;
			}
		}
	}

}