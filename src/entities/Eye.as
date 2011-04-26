package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;

	public class Eye extends Entity
	{
		[Embed(source = '../../assets/eyesheet.png')]
		private const EYE:Class;
		
		public var sprEye:Spritemap = new Spritemap(EYE, 800, 600);
		private var opening:Boolean;
		
		public function Eye()
		{
			opening = false;
			sprEye.add("rest", [0]);
			sprEye.add("openclose", [1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1], 140, true);
			
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