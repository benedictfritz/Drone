package util 
{

	public class Util 
	{
		
		public static function getLength(x:Number, y:Number):Number
		{
			var xDis:Number = Math.abs(x);
			var yDis:Number = Math.abs(y);
			return Math.abs(Math.sqrt(Math.pow(xDis, 2) + Math.pow(yDis, 2)));
		}
		
	}

}