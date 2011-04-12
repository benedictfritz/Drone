package entities 
{
	
	public class Sineblock extends Block
	{
		private var _i:Number;
		
		public function Sineblock() 
		{
			super();
		}
		
		public function init(x:Number, y:Number, i:Number):void
		{
			_i = i;
			this.x = x;
			this.y = y;
		}
		
		override public function update():void
		{
			this.y = (12 * Math.sin(_time * 20 + (.1 * _i)) * 10) + 300;
		}
		
	}

}