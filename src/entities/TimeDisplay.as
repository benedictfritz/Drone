package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	import worlds.*;
	
	public class TimeDisplay extends Entity
	{
		private var text:Text;
		public function TimeDisplay(timer:uint) 
		{
			text = new Text("0.000");
			text.color = 0x0F0F0F;
			graphic = text;
			graphic.x = 740;
			graphic.y = 560;
		}
		
		public override function update():void
		{
			text.text = String(ParticleWorld.time);
		}
	}

}