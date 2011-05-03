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
			var textColor:uint = 0x00FF00;
			
			title = new Text("drone");
			title.color = textColor;
			title.x = FP.halfWidth - (title.width*3/2);
			title.y = 20;
			title.scale = 3;
			addGraphic(title);
			
			var wasd:Text = new Text("wasd - movement");
			wasd.color = textColor;
			wasd.x = FP.halfWidth - wasd.width/2;
			wasd.y = 100;
			addGraphic(wasd);
						
			var mouse:Text = new Text("mouse - shoot");
			mouse.color = textColor;
			mouse.x = FP.halfWidth - mouse.width/2;
			mouse.y = 130;
			addGraphic(mouse);
			
			var tryIt:Text = new Text("try it out", FP.halfWidth - 40, FP.halfHeight - 40);
			tryIt.color = textColor;
			addGraphic(tryIt);
			
			reticle = new Reticle();
			add(reticle);
			
			player = new Player();
			add(player);
			player.init(FP.halfWidth, FP.halfHeight);
			
			var start:Text = new Text("shoot this block to begin");
			start.color = textColor;
			start.x =  FP.halfWidth - start.width/2;
			start.y = 520;
			addGraphic(start);
			
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