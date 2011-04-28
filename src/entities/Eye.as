package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;

	public class Eye extends Entity
	{
		[Embed(source = '../../assets/longeyesheet.png')]
		private const EYE:Class;
		
		public var sprEye:Spritemap = new Spritemap(EYE, 800, 600);
		private var opening:Boolean;
		
		public function Eye()
		{
			opening = false;
			sprEye.add("rest", [0]);
			sprEye.add("add", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			sprEye.add("openclose", [7, 8, 9, 10, 11, 12, 13, 14, 13, 12, 11, 10, 9, 8, 7], 140);
			
			graphic = sprEye;
			layer = 0;
		}
		
		override public function update():void
		{
			if(opening)
				sprEye.play("openclose");
			else
				sprEye.play("rest");
		}
		
		public function startOpening():void
		{
			opening = true;
		}
	}

}