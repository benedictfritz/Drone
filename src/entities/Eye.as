package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;

	public class Eye extends Entity
	{
		[Embed(source = '../../assets/longeyesheet2.png')]
		private const EYE:Class;
		
		public var sprEye:Spritemap = new Spritemap(EYE, 800, 600);
		private var opening:Boolean;
		private var adding:Boolean;
		
		public function Eye()
		{
			opening = false;
			adding = false;
			sprEye.add("rest", [0], 1, true);
			sprEye.add("add", [0, 1, 2, 3, 4, 5, 6, 7], 10, false);
			sprEye.add("openclose", [7, 8, 9, 10, 11, 12, 13, 14, 0, 14, 13, 12, 11, 10, 9, 8, 7], 180);
			
			graphic = sprEye;
			layer = 0;
		}
		
		override public function update():void
		{	
			if (sprEye.currentAnim == "add" && sprEye.complete) {
				opening = true;
				adding = false;
				sprEye.play("openclose");
				return;
			}
			
			if (adding)
				sprEye.play("add");
			else if (opening) {
				sprEye.play("openclose");
			}
			else
				sprEye.play("rest");
		}
		
		public function add():void
		{
			adding = true;
		}
		
		public function startOpening():void
		{
			opening = true;
		}
	}

}