package worlds 
{
	import entities.Block;
	import entities.Player;
	import entities.Reticle;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	import worlds.*;
	
	public class Menu extends World
	{
		private var title:Text;
		private var start:Text;
		private var reticle:Reticle;
		private var player:Player;
		private var block:Block;
		
		public function Menu() 
		{
			title = new Text("drone");
			title.x = FP.halfWidth - (title.width*3/2);
			title.y = 20;
			title.scale = 3;
			addGraphic(title);
			
			var wasd:Text = new Text("wasd - movement");
			wasd.x = FP.halfWidth - wasd.width/2;
			wasd.y = 100;
			addGraphic(wasd);
						
			var mouse:Text = new Text("mouse - shoot");
			mouse.x = FP.halfWidth - mouse.width/2;
			mouse.y = 130;
			addGraphic(mouse);
			
			var tryIt:Text = new Text("try it out", FP.halfWidth - 40, FP.halfHeight - 40);
			addGraphic(tryIt);
			
			reticle = new Reticle();
			add(reticle);
			
			player = new Player();
			add(player);
			player.init(FP.halfWidth, FP.halfHeight);
			
			block = new Block();
			add(block);
			block.init(FP.halfWidth, 500);
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.SPACE))
				FP.world = new ParticleWorld;
				
			super.update();
		}
		
	}

}